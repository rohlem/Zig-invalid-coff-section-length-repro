const sdl_c = @import("SDL-h");

fn t() void {unreachable;}
pub fn main() !void {
	 t();
	 _ = sdl_c.SDL_Init(0);
}
