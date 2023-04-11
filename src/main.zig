pub extern fn SDL_Init(flags: u32) c_int;

fn t() void {unreachable;}
pub fn main() !void {
	 t();
	 _ = SDL_Init(0);
}
