#!/usr/bin/env perl6

use lib './lib';
use NativeCall;
use SDL2::Raw;
use GL;

my %config = (
  title => 'xdmv2',
  shaderFragment => './shader/white.glsl',
  shaderVertex => './shader/vertex.glsl',
);

sub loadShader(Str $filename, $type) {
  my $source = CArray[Str].new([slurp $filename]);
  my $shader = glCreateShader($type);
  glShaderSource($shader, 1, $source, CArray[int32]);
  glCompileShader($shader);

  my int32 $result;
  my int32 $logLength;
  glGetShaderiv($shader, GL_COMPILE_STATUS, $result);
  glGetShaderiv($shader, GL_INFO_LOG_LENGTH, $logLength);
  if ($logLength > 0) {
    say "loadShader shader logLength > 0";
  }

  return $shader;
}

sub loadProgram() {
  my $fragmentShader = loadShader(%config<shaderFragment>, GL_FRAGMENT_SHADER);
  my $vertexShader = loadShader(%config<shaderVertex>, GL_VERTEX_SHADER);

  my $program = glCreateProgram();
  glAttachShader($program, $fragmentShader);
  glAttachShader($program, $vertexShader);
  glLinkProgram($program);

  my int32 $result;
  my int32 $logLength;
  glGetProgramiv($program, GL_LINK_STATUS, $result);
  glGetProgramiv($program, GL_INFO_LOG_LENGTH, $logLength);
  if ($logLength > 0) {
    my $buffer = CArray[uint8].new();
    $buffer[$logLength] = 0;
    my int32 $test = 0;
    glGetProgramInfoLog($program, $logLength, $test, $buffer);
    my $log = Blob.new($buffer).decode;
    say $log;
  }

  glDetachShader($program, $fragmentShader);
  glDetachShader($program, $vertexShader);
  glDeleteShader($fragmentShader);
  glDeleteShader($vertexShader);

  return $program;
}

sub main() {
  SDL_Init(VIDEO);

  my $window = SDL_CreateWindow(
    %config<title>,
    SDL_WINDOWPOS_CENTERED_MASK,
    SDL_WINDOWPOS_CENTERED_MASK,
    800, 600,
    OPENGL,
  );
  my $ctx = SDL_GL_CreateContext($window);

  my $shader = loadShader(%config<shader>);

  my $event = SDL_Event.new;
  main: loop {
    glClearColor(0e0, 0e0, 0e0, 1e0);
    glClear(GL_COLOR_BUFFER_BIT);

    SDL_GL_SwapWindow($window);
    while SDL_PollEvent($event) {
      if $event.type == QUIT {
        last main;
      }
    }
  }

  SDL_GL_DeleteContext($ctx);
  SDL_Quit()
}

main();
