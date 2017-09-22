use lib './lib';
use SDL2::Raw;
use GL;

my $title = "xdmv2";

SDL_Init(VIDEO);

my $window = SDL_CreateWindow(
  $title,
  SDL_WINDOWPOS_CENTERED_MASK,
  SDL_WINDOWPOS_CENTERED_MASK,
  800, 600,
  OPENGL,
);
my $ctx = SDL_GL_CreateContext($window);


my $event = SDL_Event.new;
main: loop {
  glClearColor(1e0, 0e0, 0e0, 1e0);
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
