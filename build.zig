const std = @import("std");

pub fn linkWithSdl(exe: *std.build.LibExeObjStep, sdl_install_path: []const u8) !void {
    const b = exe.step.owner;

    // compiling
    exe.addLibraryPathDirectorySource(.{.path = b.pathJoin(&.{sdl_install_path, "/lib/"})});

    const client_libraries = [_][]const u8{ "mingw32", "SDL2d" };
    const implementation_libraries = &[_][]const u8{ "user32", "gdi32", "winmm", "imm32", "ole32", "oleaut32", "version", "uuid", "advapi32", "setupapi", "shell32", "dinput8" };

    // linking
    exe.linkLibC();
    for (try std.mem.concat(b.allocator, []const u8, &.{ &client_libraries, implementation_libraries })) |library_name| {
        exe.linkSystemLibraryName(library_name);
    }
}

pub fn provideSdl(exe: *std.build.LibExeObjStep, target: std.zig.CrossTarget, optimize_for: std.builtin.Mode) !void {
    const b = exe.step.owner;

	 const sdl_build_install_path = "SDL-prebuilt";
    const translate_sdl_h_step = b.addTranslateC(.{
        .source_file = .{.path = b.pathJoin(&.{sdl_build_install_path, "include/SDL2/SDL.h" })},
        .target = target,
        .optimize = optimize_for,
    });

	const sdl_c = b.createModule(.{
        .source_file = .{ .generated = &translate_sdl_h_step.output_file },
        .dependencies = &.{},
    });
    exe.addModule("SDL-h", sdl_c);
    try linkWithSdl(exe, sdl_build_install_path);
    const install_bin_files_step = b.addInstallBinFile(.{.path = b.pathJoin(&.{sdl_build_install_path, "/bin/SDL2d.dll"})}, "SDL2d.dll");
    b.getInstallStep().dependOn(&install_bin_files_step.step);
}

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize_for = b.standardOptimizeOption(.{});

    // program executable
    const main_file_path = "src/main.zig";
    const exe = b.addExecutable(.{
        .name = "exe",
        .root_source_file = .{ .path = main_file_path },
        .target = target,
        .optimize = optimize_for,
    });

    try provideSdl(exe, target, optimize_for);

    exe.install();

    const run_step = b.step("run", "Run exe");
    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    run_cmd.cwd = b.exe_dir;
    run_step.dependOn(&run_cmd.step);
}
