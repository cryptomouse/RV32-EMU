
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


; MODULE: decode

; -- print includes --
; -- end print includes --
; -- print imports 'decode' --

; from import "builtin"

; end from import "builtin"

; from import "bits32"
declare %Word32 @bits32_bitmask(%Nat8 %len)
declare %Word32 @bits32_extract(%Word32 %value, %Nat8 %pos, %Nat8 %len)
declare %Word32 @bits32_insert(%Word32 %value, %Word32 %bitfield, %Nat8 %pos, %Nat8 %len)
declare %Word32 @bits32_set(%Word32 %x, %Nat8 %no)
declare %Word32 @bits32_reset(%Word32 %x, %Nat8 %no)
declare %Word32 @bits32_switch(%Word32 %x, %Nat8 %no, %Bool %val)
declare %Bool @bits32_check(%Word32 %x, %Nat8 %no)

; end from import "bits32"
; -- end print imports 'decode' --
; -- strings --
; -- endstrings --
define %Word8 @decode_extractOp(%Word32 %instr) {
	%1 = call %Word32 @bits32_extract(%Word32 %instr, %Nat8 0, %Nat8 7)
	%2 = trunc %Word32 %1 to %Word8
	ret %Word8 %2
}

define %Word8 @decode_extractFunct2(%Word32 %instr) {
	%1 = call %Word32 @bits32_extract(%Word32 %instr, %Nat8 25, %Nat8 2)
	%2 = trunc %Word32 %1 to %Word8
	ret %Word8 %2
}

define %Word8 @decode_extractFunct3(%Word32 %instr) {
	%1 = call %Word32 @bits32_extract(%Word32 %instr, %Nat8 12, %Nat8 3)
	%2 = trunc %Word32 %1 to %Word8
	ret %Word8 %2
}

define %Word8 @decode_extractFunct5(%Word32 %instr) {
	%1 = call %Word32 @bits32_extract(%Word32 %instr, %Nat8 27, %Nat8 5)
	%2 = trunc %Word32 %1 to %Word8
	ret %Word8 %2
}

define %Nat8 @decode_extractRd(%Word32 %instr) {
	%1 = call %Word32 @bits32_extract(%Word32 %instr, %Nat8 7, %Nat8 5)
	%2 = trunc %Word32 %1 to %Word8
	%3 = bitcast %Word8 %2 to %Nat8
	ret %Nat8 %3
}

define %Nat8 @decode_extractRs1(%Word32 %instr) {
	%1 = call %Word32 @bits32_extract(%Word32 %instr, %Nat8 15, %Nat8 5)
	%2 = trunc %Word32 %1 to %Word8
	%3 = bitcast %Word8 %2 to %Nat8
	ret %Nat8 %3
}

define %Nat8 @decode_extractRs2(%Word32 %instr) {
	%1 = call %Word32 @bits32_extract(%Word32 %instr, %Nat8 20, %Nat8 5)
	%2 = trunc %Word32 %1 to %Word8
	%3 = bitcast %Word8 %2 to %Nat8
	ret %Nat8 %3
}

define %Word8 @decode_extractFunct7(%Word32 %instr) {
	%1 = call %Word32 @bits32_extract(%Word32 %instr, %Nat8 25, %Nat8 7)
	%2 = trunc %Word32 %1 to %Word8
	ret %Word8 %2
}

define %Word32 @decode_extractImm12(%Word32 %instr) {
	%1 = call %Word32 @bits32_extract(%Word32 %instr, %Nat8 20, %Nat8 12)
	ret %Word32 %1
}

define %Word32 @decode_extractImm31_12(%Word32 %instr) {
	%1 = call %Word32 @bits32_extract(%Word32 %instr, %Nat8 12, %Nat8 20)
	ret %Word32 %1
}

define %Int16 @decode_extractBImm(%Word32 %instr) {
	%imm_bits = alloca %Word16, align 2
	%1 = call %Nat8 @decode_extractRd(%Word32 %instr)
	%2 = zext %Nat8 %1 to %Word16
	%3 = call %Word8 @decode_extractFunct7(%Word32 %instr)
	%4 = and %Word16 %2, 30
	%5 = and %Word8 %3, 63
	%6 = zext %Word8 %5 to %Word16
	%7 = zext i8 5 to %Word16
	%8 = shl %Word16 %6, %7
	%9 = and %Word16 %2, 1
	%10 = zext i8 11 to %Word16
	%11 = shl %Word16 %9, %10
	%12 = and %Word8 %3, 64
	%13 = zext %Word8 %12 to %Word16
	%14 = zext i8 6 to %Word16
	%15 = shl %Word16 %13, %14
	%16 = or %Word16 %15, %11
	%17 = or %Word16 %16, %8
	%18 = or %Word16 %17, %4
	store %Word16 %18, %Word16* %imm_bits
; if_0
	%19 = load %Word16, %Word16* %imm_bits
	%20 = and %Word16 %19, 4096
	%21 = icmp ne %Word16 %20, 0
	br %Bool %21 , label %then_0, label %endif_0
then_0:
	%22 = load %Word16, %Word16* %imm_bits
	%23 = or %Word16 61440, %22
	store %Word16 %23, %Word16* %imm_bits
	br label %endif_0
endif_0:
	%24 = load %Word16, %Word16* %imm_bits
	%25 = bitcast %Word16 %24 to %Int16
	ret %Int16 %25
}

define %Word32 @decode_extractJalImm(%Word32 %instr) {
	%1 = call %Word32 @decode_extractImm31_12(%Word32 %instr)
	%2 = zext i8 0 to %Word32
	%3 = lshr %Word32 %1, %2
	%4 = and %Word32 %3, 255
	%5 = zext i8 12 to %Word32
	%6 = shl %Word32 %4, %5
	%7 = zext i8 8 to %Word32
	%8 = lshr %Word32 %1, %7
	%9 = and %Word32 %8, 1
	%10 = zext i8 11 to %Word32
	%11 = shl %Word32 %9, %10
	%12 = zext i8 9 to %Word32
	%13 = lshr %Word32 %1, %12
	%14 = and %Word32 %13, 1023
	%15 = zext i8 1 to %Word32
	%16 = shl %Word32 %14, %15
	%17 = zext i8 19 to %Word32
	%18 = lshr %Word32 %1, %17
	%19 = and %Word32 %18, 1
	%20 = zext i8 20 to %Word32
	%21 = shl %Word32 %19, %20
	%22 = or %Word32 %21, %6
	%23 = or %Word32 %22, %11
	%24 = or %Word32 %23, %16
	ret %Word32 %24
}

define %Int32 @decode_expand12(%Word32 %val_12bit) {
; if_0
	%1 = and %Word32 %val_12bit, 2048
	%2 = icmp ne %Word32 %1, 0
	br %Bool %2 , label %then_0, label %endif_0
then_0:
	%3 = or %Word32 %val_12bit, 4294963200
	%4 = bitcast %Word32 %3 to %Int32
	ret %Int32 %4
	br label %endif_0
endif_0:
	%6 = bitcast %Word32 %val_12bit to %Int32
	ret %Int32 %6
}

define %Int32 @decode_expand20(%Word32 %val_20bit) {
; if_0
	%1 = and %Word32 %val_20bit, 524288
	%2 = icmp ne %Word32 %1, 0
	br %Bool %2 , label %then_0, label %endif_0
then_0:
	%3 = or %Word32 %val_20bit, 4293918720
	%4 = bitcast %Word32 %3 to %Int32
	ret %Int32 %4
	br label %endif_0
endif_0:
	%6 = bitcast %Word32 %val_20bit to %Int32
	ret %Int32 %6
}


