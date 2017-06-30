" Vim syntax file
" Language: OpenGL Shading Language (GLSL)
" Maintainer: Zach Peltzer

if exists("b:current_syntax")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn keyword glslControl if else switch case default
syn keyword glslControl while for do break continue return
syn keyword glslStatement discard

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

syn keyword glslStorage const attribute varying in out uniform buffer shared centroid sample patch

syn keyword glslPrecision precision lowp mediump highp

syn keyword glslType void bool int uint float double atomic_uint

" Vector types
syn keyword glslVector vec2 ivec2 uvec2 bvec2 vec3 ivec3 uvec3 bvec3 vec4 ivec4 uvec4 bvec4

" Matrix types
syn keyword glslMatrix mat2 dmat2 mat2x2 dmat2x2 mat2x3 dmat2x3 mat2x4 dmat2x4
syn keyword glslMatrix mat3 dmat3 mat3x3 dmat3x3 mat3x4 dmat3x4
syn keyword glslMatrix mat4 dmat4 mat4x4 dmatx4

syn keyword glslSampler sampler1D sampler2D sampler3D
syn keyword glslSampler samplerCube sampler2DRect sampler1DArray sampler2DArray 
syn keyword glslSampler samplerBuffer sampler2DMS sampler2DMSAray samplerCubeArray
syn keyword glslSampler sampler1DSahdow sampler2DShadow sampler2DRectShadow
syn keyword glslSampler sampleraDArrayShadow sampler2DArrayShadow
syn keyword glslSampler samplerCubceShadow samplerCubeArrayShadow
syn keyword glslSampler isampler1D isampler2D isampler3D
syn keyword glslSampler isamplerCube isampler2DRect isampler1DArray isampler2DArray 
syn keyword glslSampler isamplerBuffer isampler2DMS isampler2DMSAray isamplerCubeArray
syn keyword glslSampler usampler1D usampler2D usampler3D
syn keyword glslSampler usamplerCube usampler2DRect usampler1DArray usampler2DArray 
syn keyword glslSampler usamplerBuffer usampler2DMS usampler2DMSAray usamplerCubeArray

syn keyword glslImage image1D image2D image3D
syn keyword glslImage imageCube image2DRect image1DArray image2DArray 
syn keyword glslImage imageBuffer image2DMS image2DMSAray imageCubeArray
syn keyword glslImage image1DSahdow image2DShadow image2DRectShadow
syn keyword glslImage imageaDArrayShadow image2DArrayShadow
syn keyword glslImage imageCubceShadow imageCubeArrayShadow
syn keyword glslImage iimage1D iimage2D iimage3D
syn keyword glslImage iimageCube iimage2DRect iimage1DArray iimage2DArray 
syn keyword glslImage iimageBuffer iimage2DMS iimage2DMSAray iimageCubeArray
syn keyword glslImage uimage1D uimage2D uimage3D
syn keyword glslImage uimageCube uimage2DRect uimage1DArray uimage2DArray 
syn keyword glslImage uimageBuffer uimage2DMS uimage2DMSAray uimageCubeArray

syn region	glslLineComment start="//" skip="\\$" end="$" keepend
syn region	glslComment     start="/\*" end="\*/" extend

syn region glslPreProc  start="^\s*#" skip="\\$" end="$"

syn region glslParen    start="(" end=")" end="}"me=s-1 transparent contains=ALLBUT,glslParenErr
syn match  glslParenErr display ")"

syn region glslBlock    start="{" end="}" transparent contains=ALLBUT,glslBlockErr
syn match  glslBlockErr display "}"

hi def link glslControl     Statement
hi def link glslStatement	Statement
hi def link glslBoolean     Boolean
hi def link glslNumber      Number
hi def link glslFloat       Float
hi def link glslStorage     Special
hi def link glslPrecision   Special
hi def link glslType        Type
hi def link glslVector      Type
hi def link glslMatrix      Type
hi def link glslSampler     Type
hi def link glslImage       Type
hi def link glslPreProc     PreProc
hi def link glslParenErr    Error
hi def link glslBlockErr    Error
hi def link glslLineComment Comment
hi def link glslComment     Comment

let b:current_syntax = "glsl"
let &cpo = s:cpo_save
unlet s:cpo_save

