" Vim syntax file
" Language: OpenGL Shading Language (GLSL)
" Maintainer: Zach Peltzer

if exists("b:current_syntax")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn keyword glslStatement if else switch case default
syn keyword glslStatement while for do break continue return discard

syn keyword glslBoolean true false

syn case ignore
" Decimal integer
syn match glslNumber "\v<[1-9]\d*u?>"
" Octal integer (and decimal 0)
syn match glslNumber "\v<0\o*u?>"
" Hexadecimal interger
syn match glslNumber "\v<0x\x+u?>"

" Floating point number without dot with 'f' or 'lf'
syn match glslFloat "\v<\d+l?f>"
" Floating point number with dot
syn match glslFloat "\v<\d+\.\d*(e[+\-]?\d+)?(l?f)?>"
" Floating point number starting with dot
syn match glslFloat "\v\.\d+(e[+\-]?\d+)?(l?f)?>"
" FLoating point number without dot, with exponent
syn match glslFloat "\v<\d+e[+\-]?\d+(l?f)?>"
syn case match

syn keyword glslTypeQual precision struct subroutine layout
syn keyword glslPrecision lowp mediump highp

syn keyword glslLayout location origin_upper_left pixel_center_integer index
syn keyword glslLayout triangles quads isolines equal_spacing
syn keyword glslLayout fractional_even_spacing fractional_odd_spacing cw ccw
syn keyword glslLayout point_mode vertices
syn keyword glslLayout points lines lines_adjacency triangles_adjacency
syn keyword glslLayout invoations line_strip triangle_strip max_vertices stream
syn keyword glslLayout shared packed std140 row_major column_major

syn keyword glslInterpol smooth flat noperspective
syn keyword glslIOStorage centroid invariant sample patch uniform in out
syn keyword glslIOStorage inout attribute varying

syn keyword glslReserved common partition active asm class union enum
            \ typedef template this packed goto inline noinline volatile
            \ public static extern external interface long short half
            \ fixed unsigned superp input output hvec2 hvec3 hvec4 fvec2
            \ fvec3 fvec4 sampler3DRect filter image1D image2D image3D
            \ imageCube iimage1D iimage2D iimage3D iimageCube uimage1D
            \ uimage2D uimage3D uimageCube image1DArray image2DArray
            \ iimage1DArray iimage2DArray uimage1DArray uimage2DArray
            \ image1DShadow image2DShadow image1DArrayShadow
            \ image2DArrayShadow imageBuffer iimageBuffer uimageBuffer
            \ sizeof cast namespace using

syn keyword glslType void bool int uint float double atomic_uint

" Vector types
syn keyword glslType vec2 ivec2 uvec2 bvec2 vec3 ivec3 uvec3 bvec3 vec4 ivec4
syn keyword glslType uvec4 bvec4

" Matrix types
syn keyword glslType mat2 dmat2 mat2x2 dmat2x2 mat2x3 dmat2x3 mat2x4 dmat2x4
syn keyword glslType mat3 dmat3 mat3x3 dmat3x3 mat3x4 dmat3x4
syn keyword glslType mat4 dmat4 mat4x4 dmatx4

syn keyword glslType sampler1D sampler2D sampler3D
syn keyword glslType samplerCube sampler2DRect sampler1DArray sampler2DArray 
syn keyword glslType samplerBuffer sampler2DMS sampler2DMSAray
syn keyword glslType samplerCubeArray
syn keyword glslType sampler1DSahdow sampler2DShadow sampler2DRectShadow
syn keyword glslType sampleraDArrayShadow sampler2DArrayShadow
syn keyword glslType samplerCubceShadow samplerCubeArrayShadow
syn keyword glslType isampler1D isampler2D isampler3D
syn keyword glslType isamplerCube isampler2DRect isampler1DArray
syn keyword glslType isampler2DArray 
syn keyword glslType isamplerBuffer isampler2DMS isampler2DMSAray
syn keyword glslType isamplerCubeArray
syn keyword glslType usampler1D usampler2D usampler3D
syn keyword glslType usamplerCube usampler2DRect usampler1DArray
syn keyword glslType usampler2DArray 
syn keyword glslType usamplerBuffer usampler2DMS usampler2DMSAray
syn keyword glslType usamplerCubeArray

syn keyword glslFunction radians degrees sin cos tan asin acos atan sinh cosh
syn keyword glslFunction tanh asinh acosh atanh
syn keyword glslFunction pow exp log exp2 log2 sqrt inversesqrt
syn keyword glslFunction abs sign floor trunc round roundEven ceil fract mod
syn keyword glslFunction modf min max clamp mix step smoothstep isnan isinf
syn keyword glslFunction floatBitsToInt floatBitsToUint intBitsToFloat
syn keyword glslFunction uintBitsToFloat fma frexp ldexp
syn keyword glslFunction packUnorm2x16 packUnorm4x8 packSnorm4x8
syn keyword glslFunction unpackUnorm2x16 unpackUnorm4x8 unpackSnorm4x8
syn keyword glslFunction packDouble2x32 unpackDouble2x32
syn keyword glslFunction length distance dot cross normalize ftransform
syn keyword glslFunction faceforeward reflect refract
syn keyword glslFunction matrixCompMult outerProduct transpose determinant
syn keyword glslFunction inverse
syn keyword glslFunction lessThan lessThanEqual greaterThan greaterThanEqual
syn keyword glslFunction equal notEqual any all not
syn keyword glslFunction uaddCarry usubBorrow umulExtended imulExtended
syn keyword glslFunction bitfieldExtract bitfieldInsert bitfieldReverse
syn keyword glslFunction bitCount findLSB findMSB
syn keyword glslFunction textureSize textureQueryLod texture textureProj
syn keyword glslFunction textureLod textureOffset texelFetch texelFetchOffset
syn keyword glslFunction textureProjOffset textureLodOffset textureProjLod
syn keyword glslFunction textureProjLodOffset textureGrad textureGradOffset
syn keyword glslFunction textureProjGrad textureProjGradOffset
syn keyword glslFunction textureGather textureGatherOffset
syn keyword glslFunction textureGatherOffsets
syn keyword glslFunction dFdx dFdy fwidth
syn keyword glslFunction interpolateAtCentroid interpolateAtSample
syn keyword glslFunction interpolateAtOffset
syn keyword glslFunction noise1 noise2 noise3 noise4

syn match glslBuiltin "\<gl_\w\+"

syn match glslOperator "\V\(+\|-\|*\|/\|%\|++\|--\|&\||\|^\|~\|&&\|||\|!\|>\|<\|==\|>=\|<=\|!=\|=\|+=\|-=\|*=\|/=\|?\|:\)"

syn region	glslComment start="//" skip="\\$" end="$" keepend contains=glslTODO
syn region	glslComment     start="/\*" end="\*/" extend contains=glslTODO
syn keyword glslTODO TODO FIXME XXX contained

syn region glslPreProc  start="^\s*#" skip="\\$" end="$"

hi def link glslStatement   Statement
hi def link glslBoolean     Boolean
hi def link glslNumber      Number
hi def link glslFloat       Float
hi def link glslTypeQual    Typedef
hi def link glslPrecision   Special
hi def link glslLayout      Keyword
hi def link glslInterpol    String
hi def link glslIOStorage   Include
hi def link glslType        Type
hi def link glslBuiltin     Constant
hi def link glslFunction    Function
hi def link glslOperator    Operator
hi def link glslComment     Comment
hi def link glslTODO        Todo
hi def link glslPreProc     PreProc
hi def link glslReserved    Error

let b:current_syntax = "glsl"
let &cpo = s:cpo_save
unlet s:cpo_save

