
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx27.0.0"


%Unit = type i1
%Bool = type i1
%Byte = type i8
%Word8 = type i8
%Word16 = type i16
%Word32 = type i32
%Word64 = type i64
%Word128 = type i128
%Word256 = type i256
%Char8 = type i8
%Char16 = type i16
%Char32 = type i32
%Int8 = type i8
%Int16 = type i16
%Int32 = type i32
%Int64 = type i64
%Int128 = type i128
%Int256 = type i256
%Nat8 = type i8
%Nat16 = type i16
%Nat32 = type i32
%Nat64 = type i64
%Nat128 = type i128
%Nat256 = type i256
%Float16 = type half
%Float32 = type float
%Float64 = type double
%Fixed32 = type i32
%Fixed64 = type i64
%Size = type i64
%Pointer = type i8*
%Str8 = type [0 x %Char8]
%Str16 = type [0 x %Char16]
%Str32 = type [0 x %Char32]
%__VA_List = type i8*
declare void @llvm.memcpy.p0.p0.i32(i8*, i8*, i32, i1)
declare void @llvm.memset.p0.i32(i8*, i8, i32, i1)

declare i8* @llvm.stacksave()

declare void @llvm.stackrestore(i8*)


; MODULE: mmio

; -- print includes --
; from included ctypes64
%Str = type %Str8;
%Char = type %Char8;
%ConstChar = type %Char;
%SignedChar = type %Int8;
%UnsignedChar = type %Nat8;
%Short = type %Int16;
%UnsignedShort = type %Nat16;
%Int = type %Int32;
%UnsignedInt = type %Nat32;
%LongInt = type %Int64;
%UnsignedLongInt = type %Nat64;
%Long = type %Int64;
%UnsignedLong = type %Nat64;
%LongLong = type %Int64;
%UnsignedLongLong = type %Nat64;
%LongLongInt = type %Int64;
%UnsignedLongLongInt = type %Nat64;
%Float = type %Float32;
%Double = type %Float64;
%LongDouble = type %Float64;
%SizeT = type %UnsignedLongInt;
%SSizeT = type %LongInt;
%IntPtrT = type %Nat64;
%PtrDiffT = type %Int64;
%OffT = type %Int64;
%USecondsT = type %Nat32;
%PIDT = type %Int32;
%UIDT = type %Nat32;
%GIDT = type %Nat32;
; from included ctypes
; from included stdio
%File = type {
};

%FposT = type %Nat8;
%CharStr = type %Str;
%ConstCharStr = type %CharStr;
declare %Int @fclose(i8* %f)
declare %Int @feof(i8* %f)
declare %Int @ferror(i8* %f)
declare %Int @fflush(i8* %f)
declare %Int @fgetpos(i8* %f, %FposT* %pos)
declare i8* @fopen(%ConstCharStr* %fname, %ConstCharStr* %mode)
declare %SizeT @fread(i8* %buf, %SizeT %size, %SizeT %count, i8* %f)
declare %SizeT @fwrite(i8* %buf, %SizeT %size, %SizeT %count, i8* %f)
declare i8* @freopen(%ConstCharStr* %fname, %ConstCharStr* %mode, i8* %f)
declare %Int @fseek(i8* %f, %LongInt %offset, %Int %whence)
declare %Int @fsetpos(i8* %f, %FposT* %pos)
declare %LongInt @ftell(i8* %f)
declare %Int @remove(%ConstCharStr* %fname)
declare %Int @rename(%ConstCharStr* %old_filename, %ConstCharStr* %new_filename)
declare void @rewind(i8* %f)
declare void @setbuf(i8* %f, %CharStr* %buf)
declare %Int @setvbuf(i8* %f, %CharStr* %buf, %Int %mode, %SizeT %size)
declare i8* @tmpfile()
declare %CharStr* @tmpnam(%CharStr* %str)
declare %Int @printf(%ConstCharStr* %str, ...)
declare %Int @scanf(%ConstCharStr* %str, ...)
declare %Int @fprintf(i8* %f, %Str* %format, ...)
declare %Int @fscanf(i8* %f, %ConstCharStr* %format, ...)
declare %Int @sscanf(%ConstCharStr* %buf, %ConstCharStr* %format, ...)
declare %Int @sprintf(%CharStr* %buf, %ConstCharStr* %format, ...)
declare %Int @snprintf(%CharStr* %buf, %SizeT %size, %ConstCharStr* %format, ...)
declare %Int @vfprintf(i8* %f, %ConstCharStr* %format, %__VA_List %args)
declare %Int @vprintf(%ConstCharStr* %format, %__VA_List %args)
declare %Int @vsprintf(%CharStr* %str, %ConstCharStr* %format, %__VA_List %args)
declare %Int @vsnprintf(%CharStr* %str, %SizeT %n, %ConstCharStr* %format, %__VA_List %args)
declare %Int @__vsnprintf_chk(%CharStr* %dest, %SizeT %len, %Int %flags, %SizeT %dstlen, %ConstCharStr* %format, %__VA_List %arg)
declare %Int @fgetc(i8* %f)
declare %Int @fputc(%Int %char, i8* %f)
declare %CharStr* @fgets(%CharStr* %str, %Int %n, i8* %f)
declare %Int @fputs(%ConstCharStr* %str, i8* %f)
declare %Int @getc(i8* %f)
declare %Int @getchar()
declare %Int @putc(%Int %char, i8* %f)
declare %Int @putchar(%Int %char)
declare %Int @puts(%ConstCharStr* %str)
declare %Int @ungetc(%Int %char, i8* %f)
declare void @perror(%ConstCharStr* %str)
; -- end print includes --
; -- print imports 'mmio' --

; from import "builtin"

; end from import "builtin"

; from import "sdl"
%Window = type {
};

%Renderer = type {
};

%Texture = type {
};

%Rect = type {
	%Int32,
	%Int32,
	%Int32,
	%Int32
};

%Event = type {
};

declare external %Int32 @init(%Word32 %flags)
declare external void @shutdown()
declare external %ConstCharStr* @getError()
declare external void @delay(%Nat32 %ms)
declare external i8* @createWindow(%ConstCharStr* %title, %Int32 %x, %Int32 %y, %Int32 %w, %Int32 %h, %Word32 %flags)
declare external void @destroyWindow(i8* %window)
declare external i8* @createRenderer(i8* %window, %Int32 %index, %Word32 %flags)
declare external void @destroyRenderer(i8* %renderer)
declare external %Int32 @renderClear(i8* %renderer)
declare external %Int32 @renderCopy(i8* %renderer, i8* %texture, %Rect* %srcrect, %Rect* %dstrect)
declare external void @renderPresent(i8* %renderer)
declare external i8* @createTexture(i8* %renderer, %Nat32 %format, %Int32 %access, %Int32 %w, %Int32 %h)
declare external void @destroyTexture(i8* %texture)
declare external %Int32 @updateTexture(i8* %texture, %Rect* %rect, i8* %pixels, %Int32 %pitch)
declare external %Int32 @pollEvent(i8* %event)

; end from import "sdl"

; from import "display"
%display_MemMap = type i8* (%Nat32, %Nat32)*;
declare void @display_init(%display_MemMap %mm)
declare %Bool @display_isOn()
declare %Word32 @display_read32(%Nat32 %adr)
declare void @display_write32(%Nat32 %adr, %Word32 %value)
declare %Bool @display_poll()
declare void @display_waitClose()
declare void @display_shutdown()

; end from import "display"
; -- end print imports 'mmio' --
; -- strings --
@.str1 = private constant [3 x i8] [i8 37, i8 100, i8 0]
@.str2 = private constant [3 x i8] [i8 37, i8 117, i8 0]
@.str3 = private constant [3 x i8] [i8 37, i8 120, i8 0]
@.str4 = private constant [3 x i8] [i8 37, i8 120, i8 0]
; -- endstrings --
define void @mmio_write8(%Nat32 %adr, %Word8 %value) {
; if_0
	%1 = icmp eq %Nat32 %adr, 16
	br %Bool %1 , label %then_0, label %endif_0
then_0:
	%2 = sext %Word8 %value to %Int
	%3 = call %Int @putchar(%Int %2)
	ret void
	br label %endif_0
endif_0:
	ret void
}

define void @mmio_write16(%Nat32 %adr, %Word16 %value) {
; if_0
	%1 = icmp eq %Nat32 %adr, 16
	br %Bool %1 , label %then_0, label %endif_0
then_0:
	%2 = sext %Word16 %value to %Int
	%3 = call %Int @putchar(%Int %2)
	ret void
	br label %endif_0
endif_0:
	ret void
}

define void @mmio_write32(%Nat32 %adr, %Word32 %value) {
; if_0
	%1 = icmp eq %Nat32 %adr, 16
	br %Bool %1 , label %then_0, label %else_0
then_0:
	%2 = bitcast %Word32 %value to %Int
	%3 = call %Int @putchar(%Int %2)
	ret void
	br label %endif_0
else_0:
; if_1
	%5 = icmp eq %Nat32 %adr, 32
	br %Bool %5 , label %then_1, label %else_1
then_1:
	%6 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([3 x i8]* @.str1 to [0 x i8]*), %Word32 %value)
	ret void
	br label %endif_1
else_1:
; if_2
	%8 = icmp eq %Nat32 %adr, 36
	br %Bool %8 , label %then_2, label %else_2
then_2:
	%9 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([3 x i8]* @.str2 to [0 x i8]*), %Word32 %value)
	ret void
	br label %endif_2
else_2:
; if_3
	%11 = icmp eq %Nat32 %adr, 40
	br %Bool %11 , label %then_3, label %else_3
then_3:
	%12 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([3 x i8]* @.str3 to [0 x i8]*), %Word32 %value)
	ret void
	br label %endif_3
else_3:
; if_4
	%14 = icmp eq %Nat32 %adr, 44
	br %Bool %14 , label %then_4, label %else_4
then_4:
	%15 = call %Int (%ConstCharStr*, ...) @printf(%ConstCharStr* bitcast ([3 x i8]* @.str4 to [0 x i8]*), %Word32 %value)
	ret void
	br label %endif_4
else_4:
; if_5
	%17 = call %Bool @isDisplayAdr(%Nat32 %adr)
	br %Bool %17 , label %then_5, label %endif_5
then_5:
	%18 = sub %Nat32 %adr, 4096
	call void @display_write32(%Nat32 %18, %Word32 %value)
	ret void
	br label %endif_5
endif_5:
	br label %endif_4
endif_4:
	br label %endif_3
endif_3:
	br label %endif_2
endif_2:
	br label %endif_1
endif_1:
	br label %endif_0
endif_0:
	ret void
}

define %Word8 @mmio_read8(%Nat32 %adr) {
	%1 = bitcast i8 0 to %Word8
	ret %Word8 %1
}

define %Word16 @mmio_read16(%Nat32 %adr) {
	%1 = zext i8 0 to %Word16
	ret %Word16 %1
}

define %Word32 @mmio_read32(%Nat32 %adr) {
; if_0
	%1 = call %Bool @isDisplayAdr(%Nat32 %adr)
	br %Bool %1 , label %then_0, label %endif_0
then_0:
	%2 = sub %Nat32 %adr, 4096
	%3 = call %Word32 @display_read32(%Nat32 %2)
	ret %Word32 %3
	br label %endif_0
endif_0:
	%5 = zext i8 0 to %Word32
	ret %Word32 %5
}

define internal %Bool @isDisplayAdr(%Nat32 %adr) alwaysinline {
	%1 = icmp uge %Nat32 %adr, 4096
	%2 = icmp ult %Nat32 %adr, 8192
	%3 = and %Bool %1, %2
	ret %Bool %3
}


