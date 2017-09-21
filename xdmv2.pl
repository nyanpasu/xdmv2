use SDL2::Raw;

my $title = "xdmv2";

SDL_Init(VIDEO);

my $window = SDL_CreateWindow(
  $title,
  SDL_WINDOWPOS_CENTERED_MASK,
  SDL_WINDOWPOS_CENTERED_MASK,
  800, 600,
  OPENGL
);
my $renderer = SDL_CreateRenderer($window, -1, 0);

SDL_RenderClear($renderer);
SDL_SetRenderDrawColor($renderer, 255, 255, 255, 255);
SDL_RenderPresent($renderer);

my $event = SDL_Event.new;
main: loop {
  while SDL_PollEvent($event) {
    if $event.type == QUIT {
      last main;
    }
  }
}

SDL_Quit()
