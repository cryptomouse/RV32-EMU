// sdl2.m - minimal SDL2 binding (only what the display controller needs)
//
// NOTE: modules importing it must be built with the C backend: the LLVM backend
// ignores the C name given by @extern("C", ...) and emits the Modest name

pragma do_not_include
pragma prefix ""
pragma c_include "SDL2/SDL.h"

include "libc/ctypes64"
include "libc/stdio"


@extern("C", "SDL_Window")
public type Window = {}

@extern("C", "SDL_Renderer")
public type Renderer = {}

@extern("C", "SDL_Texture")
public type Texture = {}

@extern("C", "SDL_Rect")
public type Rect = @public {
	x: Int32
	y: Int32
	w: Int32
	h: Int32
}

// SDL_Event is a union whose first field 'type' (Uint32) is a Modest keyword,
// so the record is kept opaque; the event type is its first 4 bytes
@extern("C", "SDL_Event")
public type Event = {}

@extern("C", "SDL_INIT_VIDEO")
public const initVideo: Word32 = 0x00000020

@extern("C", "SDL_WINDOWPOS_CENTERED")
public const windowposCentered: Int32 = 0x2FFF0000

@extern("C", "SDL_WINDOW_SHOWN")
public const windowShown: Word32 = 0x00000004

@extern("C", "SDL_RENDERER_ACCELERATED")
public const rendererAccelerated: Word32 = 0x00000002

@extern("C", "SDL_RENDERER_PRESENTVSYNC")
public const rendererPresentvsync: Word32 = 0x00000004

@extern("C", "SDL_PIXELFORMAT_ARGB8888")
public const pixelformatArgb8888: Nat32 = 0x16362004

@extern("C", "SDL_TEXTUREACCESS_STREAMING")
public const textureaccessStreaming: Int32 = 1

@extern("C", "SDL_QUIT")
public const quit: Nat32 = 0x100


@extern("C", "SDL_Init")
public func init (flags: Word32) -> Int32
@extern("C", "SDL_Quit")
public func shutdown () -> Unit
@extern("C", "SDL_GetError")
public func getError () -> *ConstCharStr
@extern("C", "SDL_Delay")
public func delay (ms: Nat32) -> Unit

@extern("C", "SDL_CreateWindow")
public func createWindow (title: *ConstCharStr, x: Int32, y: Int32, w: Int32, h: Int32, flags: Word32) -> *Window
@extern("C", "SDL_DestroyWindow")
public func destroyWindow (window: *Window) -> Unit

@extern("C", "SDL_CreateRenderer")
public func createRenderer (window: *Window, index: Int32, flags: Word32) -> *Renderer
@extern("C", "SDL_DestroyRenderer")
public func destroyRenderer (renderer: *Renderer) -> Unit
@extern("C", "SDL_RenderClear")
public func renderClear (renderer: *Renderer) -> @unused Int32
@extern("C", "SDL_RenderCopy")
public func renderCopy (renderer: *Renderer, texture: *Texture, srcrect: *Rect, dstrect: *Rect) -> @unused Int32
@extern("C", "SDL_RenderPresent")
public func renderPresent (renderer: *Renderer) -> Unit

@extern("C", "SDL_CreateTexture")
public func createTexture (renderer: *Renderer, format: Nat32, access: Int32, w: Int32, h: Int32) -> *Texture
@extern("C", "SDL_DestroyTexture")
public func destroyTexture (texture: *Texture) -> Unit
@extern("C", "SDL_UpdateTexture")
public func updateTexture (texture: *Texture, rect: *Rect, pixels: Ptr, pitch: Int32) -> @unused Int32

@extern("C", "SDL_PollEvent")
public func pollEvent (event: *Event) -> Int32

