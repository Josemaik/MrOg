                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module tiles
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _tiles_11
                             12 	.globl _tiles_10
                             13 	.globl _tiles_09
                             14 	.globl _tiles_08
                             15 	.globl _tiles_07
                             16 	.globl _tiles_06
                             17 	.globl _tiles_05
                             18 	.globl _tiles_04
                             19 	.globl _tiles_03
                             20 	.globl _tiles_02
                             21 	.globl _tiles_01
                             22 	.globl _tiles_00
                             23 ;--------------------------------------------------------
                             24 ; special function registers
                             25 ;--------------------------------------------------------
                             26 ;--------------------------------------------------------
                             27 ; ram data
                             28 ;--------------------------------------------------------
                             29 	.area _DATA
                             30 ;--------------------------------------------------------
                             31 ; ram data
                             32 ;--------------------------------------------------------
                             33 	.area _INITIALIZED
                             34 ;--------------------------------------------------------
                             35 ; absolute external ram data
                             36 ;--------------------------------------------------------
                             37 	.area _DABS (ABS)
                             38 ;--------------------------------------------------------
                             39 ; global & static initialisations
                             40 ;--------------------------------------------------------
                             41 	.area _HOME
                             42 	.area _GSINIT
                             43 	.area _GSFINAL
                             44 	.area _GSINIT
                             45 ;--------------------------------------------------------
                             46 ; Home
                             47 ;--------------------------------------------------------
                             48 	.area _HOME
                             49 	.area _HOME
                             50 ;--------------------------------------------------------
                             51 ; code
                             52 ;--------------------------------------------------------
                             53 	.area _CODE
                             54 	.area _CODE
   4300                      55 _tiles_00:
   4300 5C                   56 	.db #0x5c	; 92
   4301 FC                   57 	.db #0xfc	; 252
   4302 5C                   58 	.db #0x5c	; 92
   4303 FC                   59 	.db #0xfc	; 252
   4304 0C                   60 	.db #0x0c	; 12
   4305 0C                   61 	.db #0x0c	; 12
   4306 0C                   62 	.db #0x0c	; 12
   4307 0C                   63 	.db #0x0c	; 12
   4308 FC                   64 	.db #0xfc	; 252
   4309 5C                   65 	.db #0x5c	; 92
   430A FC                   66 	.db #0xfc	; 252
   430B 5C                   67 	.db #0x5c	; 92
   430C 0C                   68 	.db #0x0c	; 12
   430D 0C                   69 	.db #0x0c	; 12
   430E 0C                   70 	.db #0x0c	; 12
   430F 0C                   71 	.db #0x0c	; 12
   4310 5C                   72 	.db #0x5c	; 92
   4311 FC                   73 	.db #0xfc	; 252
   4312 5C                   74 	.db #0x5c	; 92
   4313 FC                   75 	.db #0xfc	; 252
   4314 0C                   76 	.db #0x0c	; 12
   4315 0C                   77 	.db #0x0c	; 12
   4316 0C                   78 	.db #0x0c	; 12
   4317 0C                   79 	.db #0x0c	; 12
   4318 FC                   80 	.db #0xfc	; 252
   4319 5C                   81 	.db #0x5c	; 92
   431A FC                   82 	.db #0xfc	; 252
   431B 5C                   83 	.db #0x5c	; 92
   431C 0C                   84 	.db #0x0c	; 12
   431D 0C                   85 	.db #0x0c	; 12
   431E 0C                   86 	.db #0x0c	; 12
   431F 0C                   87 	.db #0x0c	; 12
   4320                      88 _tiles_01:
   4320 F2                   89 	.db #0xf2	; 242
   4321 F0                   90 	.db #0xf0	; 240
   4322 F0                   91 	.db #0xf0	; 240
   4323 F1                   92 	.db #0xf1	; 241
   4324 F0                   93 	.db #0xf0	; 240
   4325 F0                   94 	.db #0xf0	; 240
   4326 F0                   95 	.db #0xf0	; 240
   4327 F0                   96 	.db #0xf0	; 240
   4328 F0                   97 	.db #0xf0	; 240
   4329 B0                   98 	.db #0xb0	; 176
   432A F0                   99 	.db #0xf0	; 240
   432B F0                  100 	.db #0xf0	; 240
   432C F0                  101 	.db #0xf0	; 240
   432D F0                  102 	.db #0xf0	; 240
   432E B0                  103 	.db #0xb0	; 176
   432F F0                  104 	.db #0xf0	; 240
   4330 F0                  105 	.db #0xf0	; 240
   4331 70                  106 	.db #0x70	; 112	'p'
   4332 F0                  107 	.db #0xf0	; 240
   4333 F0                  108 	.db #0xf0	; 240
   4334 F2                  109 	.db #0xf2	; 242
   4335 F0                  110 	.db #0xf0	; 240
   4336 F0                  111 	.db #0xf0	; 240
   4337 F1                  112 	.db #0xf1	; 241
   4338 F3                  113 	.db #0xf3	; 243
   4339 E3                  114 	.db #0xe3	; 227
   433A D3                  115 	.db #0xd3	; 211
   433B F3                  116 	.db #0xf3	; 243
   433C F3                  117 	.db #0xf3	; 243
   433D C3                  118 	.db #0xc3	; 195
   433E C3                  119 	.db #0xc3	; 195
   433F F3                  120 	.db #0xf3	; 243
   4340                     121 _tiles_02:
   4340 F3                  122 	.db #0xf3	; 243
   4341 F3                  123 	.db #0xf3	; 243
   4342 F3                  124 	.db #0xf3	; 243
   4343 F3                  125 	.db #0xf3	; 243
   4344 A7                  126 	.db #0xa7	; 167
   4345 F3                  127 	.db #0xf3	; 243
   4346 F3                  128 	.db #0xf3	; 243
   4347 F3                  129 	.db #0xf3	; 243
   4348 F3                  130 	.db #0xf3	; 243
   4349 F3                  131 	.db #0xf3	; 243
   434A F2                  132 	.db #0xf2	; 242
   434B F3                  133 	.db #0xf3	; 243
   434C F3                  134 	.db #0xf3	; 243
   434D F3                  135 	.db #0xf3	; 243
   434E F3                  136 	.db #0xf3	; 243
   434F F3                  137 	.db #0xf3	; 243
   4350 F3                  138 	.db #0xf3	; 243
   4351 F3                  139 	.db #0xf3	; 243
   4352 F3                  140 	.db #0xf3	; 243
   4353 F3                  141 	.db #0xf3	; 243
   4354 F3                  142 	.db #0xf3	; 243
   4355 A7                  143 	.db #0xa7	; 167
   4356 F3                  144 	.db #0xf3	; 243
   4357 F3                  145 	.db #0xf3	; 243
   4358 F2                  146 	.db #0xf2	; 242
   4359 F3                  147 	.db #0xf3	; 243
   435A F3                  148 	.db #0xf3	; 243
   435B F3                  149 	.db #0xf3	; 243
   435C F3                  150 	.db #0xf3	; 243
   435D F3                  151 	.db #0xf3	; 243
   435E F3                  152 	.db #0xf3	; 243
   435F 5B                  153 	.db #0x5b	; 91
   4360                     154 _tiles_03:
   4360 FF                  155 	.db #0xff	; 255
   4361 FF                  156 	.db #0xff	; 255
   4362 FF                  157 	.db #0xff	; 255
   4363 FF                  158 	.db #0xff	; 255
   4364 FF                  159 	.db #0xff	; 255
   4365 FF                  160 	.db #0xff	; 255
   4366 FF                  161 	.db #0xff	; 255
   4367 FF                  162 	.db #0xff	; 255
   4368 FF                  163 	.db #0xff	; 255
   4369 FF                  164 	.db #0xff	; 255
   436A FF                  165 	.db #0xff	; 255
   436B FF                  166 	.db #0xff	; 255
   436C FF                  167 	.db #0xff	; 255
   436D FF                  168 	.db #0xff	; 255
   436E FF                  169 	.db #0xff	; 255
   436F FF                  170 	.db #0xff	; 255
   4370 FF                  171 	.db #0xff	; 255
   4371 FF                  172 	.db #0xff	; 255
   4372 FF                  173 	.db #0xff	; 255
   4373 FF                  174 	.db #0xff	; 255
   4374 FF                  175 	.db #0xff	; 255
   4375 FF                  176 	.db #0xff	; 255
   4376 FF                  177 	.db #0xff	; 255
   4377 FF                  178 	.db #0xff	; 255
   4378 FF                  179 	.db #0xff	; 255
   4379 FF                  180 	.db #0xff	; 255
   437A FF                  181 	.db #0xff	; 255
   437B FF                  182 	.db #0xff	; 255
   437C FF                  183 	.db #0xff	; 255
   437D FF                  184 	.db #0xff	; 255
   437E FF                  185 	.db #0xff	; 255
   437F FF                  186 	.db #0xff	; 255
   4380                     187 _tiles_04:
   4380 FF                  188 	.db #0xff	; 255
   4381 FF                  189 	.db #0xff	; 255
   4382 FF                  190 	.db #0xff	; 255
   4383 FF                  191 	.db #0xff	; 255
   4384 FF                  192 	.db #0xff	; 255
   4385 FF                  193 	.db #0xff	; 255
   4386 FF                  194 	.db #0xff	; 255
   4387 FF                  195 	.db #0xff	; 255
   4388 FF                  196 	.db #0xff	; 255
   4389 FF                  197 	.db #0xff	; 255
   438A FF                  198 	.db #0xff	; 255
   438B FF                  199 	.db #0xff	; 255
   438C FF                  200 	.db #0xff	; 255
   438D FF                  201 	.db #0xff	; 255
   438E FF                  202 	.db #0xff	; 255
   438F FF                  203 	.db #0xff	; 255
   4390 FF                  204 	.db #0xff	; 255
   4391 FF                  205 	.db #0xff	; 255
   4392 FF                  206 	.db #0xff	; 255
   4393 FF                  207 	.db #0xff	; 255
   4394 FF                  208 	.db #0xff	; 255
   4395 FF                  209 	.db #0xff	; 255
   4396 FF                  210 	.db #0xff	; 255
   4397 FF                  211 	.db #0xff	; 255
   4398 FF                  212 	.db #0xff	; 255
   4399 FF                  213 	.db #0xff	; 255
   439A FF                  214 	.db #0xff	; 255
   439B FF                  215 	.db #0xff	; 255
   439C FF                  216 	.db #0xff	; 255
   439D FF                  217 	.db #0xff	; 255
   439E FF                  218 	.db #0xff	; 255
   439F FF                  219 	.db #0xff	; 255
   43A0                     220 _tiles_05:
   43A0 FF                  221 	.db #0xff	; 255
   43A1 FF                  222 	.db #0xff	; 255
   43A2 FF                  223 	.db #0xff	; 255
   43A3 FF                  224 	.db #0xff	; 255
   43A4 FF                  225 	.db #0xff	; 255
   43A5 FF                  226 	.db #0xff	; 255
   43A6 FF                  227 	.db #0xff	; 255
   43A7 FF                  228 	.db #0xff	; 255
   43A8 FF                  229 	.db #0xff	; 255
   43A9 FF                  230 	.db #0xff	; 255
   43AA FF                  231 	.db #0xff	; 255
   43AB FF                  232 	.db #0xff	; 255
   43AC FF                  233 	.db #0xff	; 255
   43AD FF                  234 	.db #0xff	; 255
   43AE FF                  235 	.db #0xff	; 255
   43AF FF                  236 	.db #0xff	; 255
   43B0 FF                  237 	.db #0xff	; 255
   43B1 FF                  238 	.db #0xff	; 255
   43B2 FF                  239 	.db #0xff	; 255
   43B3 FF                  240 	.db #0xff	; 255
   43B4 FF                  241 	.db #0xff	; 255
   43B5 FF                  242 	.db #0xff	; 255
   43B6 FF                  243 	.db #0xff	; 255
   43B7 FF                  244 	.db #0xff	; 255
   43B8 FF                  245 	.db #0xff	; 255
   43B9 FF                  246 	.db #0xff	; 255
   43BA FF                  247 	.db #0xff	; 255
   43BB FF                  248 	.db #0xff	; 255
   43BC FF                  249 	.db #0xff	; 255
   43BD FF                  250 	.db #0xff	; 255
   43BE FF                  251 	.db #0xff	; 255
   43BF FF                  252 	.db #0xff	; 255
   43C0                     253 _tiles_06:
   43C0 FF                  254 	.db #0xff	; 255
   43C1 FF                  255 	.db #0xff	; 255
   43C2 FF                  256 	.db #0xff	; 255
   43C3 FF                  257 	.db #0xff	; 255
   43C4 FF                  258 	.db #0xff	; 255
   43C5 FF                  259 	.db #0xff	; 255
   43C6 FF                  260 	.db #0xff	; 255
   43C7 FF                  261 	.db #0xff	; 255
   43C8 FF                  262 	.db #0xff	; 255
   43C9 FF                  263 	.db #0xff	; 255
   43CA FF                  264 	.db #0xff	; 255
   43CB FF                  265 	.db #0xff	; 255
   43CC FF                  266 	.db #0xff	; 255
   43CD FF                  267 	.db #0xff	; 255
   43CE FF                  268 	.db #0xff	; 255
   43CF FF                  269 	.db #0xff	; 255
   43D0 FF                  270 	.db #0xff	; 255
   43D1 FF                  271 	.db #0xff	; 255
   43D2 FF                  272 	.db #0xff	; 255
   43D3 FF                  273 	.db #0xff	; 255
   43D4 FF                  274 	.db #0xff	; 255
   43D5 FF                  275 	.db #0xff	; 255
   43D6 FF                  276 	.db #0xff	; 255
   43D7 FF                  277 	.db #0xff	; 255
   43D8 FF                  278 	.db #0xff	; 255
   43D9 FF                  279 	.db #0xff	; 255
   43DA FF                  280 	.db #0xff	; 255
   43DB FF                  281 	.db #0xff	; 255
   43DC FF                  282 	.db #0xff	; 255
   43DD FF                  283 	.db #0xff	; 255
   43DE FF                  284 	.db #0xff	; 255
   43DF FF                  285 	.db #0xff	; 255
   43E0                     286 _tiles_07:
   43E0 FF                  287 	.db #0xff	; 255
   43E1 FF                  288 	.db #0xff	; 255
   43E2 FF                  289 	.db #0xff	; 255
   43E3 FF                  290 	.db #0xff	; 255
   43E4 FF                  291 	.db #0xff	; 255
   43E5 FF                  292 	.db #0xff	; 255
   43E6 FF                  293 	.db #0xff	; 255
   43E7 FF                  294 	.db #0xff	; 255
   43E8 FF                  295 	.db #0xff	; 255
   43E9 FF                  296 	.db #0xff	; 255
   43EA FF                  297 	.db #0xff	; 255
   43EB FF                  298 	.db #0xff	; 255
   43EC FF                  299 	.db #0xff	; 255
   43ED FF                  300 	.db #0xff	; 255
   43EE FF                  301 	.db #0xff	; 255
   43EF FF                  302 	.db #0xff	; 255
   43F0 FF                  303 	.db #0xff	; 255
   43F1 FF                  304 	.db #0xff	; 255
   43F2 FF                  305 	.db #0xff	; 255
   43F3 FF                  306 	.db #0xff	; 255
   43F4 FF                  307 	.db #0xff	; 255
   43F5 FF                  308 	.db #0xff	; 255
   43F6 FF                  309 	.db #0xff	; 255
   43F7 FF                  310 	.db #0xff	; 255
   43F8 FF                  311 	.db #0xff	; 255
   43F9 FF                  312 	.db #0xff	; 255
   43FA FF                  313 	.db #0xff	; 255
   43FB FF                  314 	.db #0xff	; 255
   43FC FF                  315 	.db #0xff	; 255
   43FD FF                  316 	.db #0xff	; 255
   43FE FF                  317 	.db #0xff	; 255
   43FF FF                  318 	.db #0xff	; 255
   4400                     319 _tiles_08:
   4400 FF                  320 	.db #0xff	; 255
   4401 FF                  321 	.db #0xff	; 255
   4402 FF                  322 	.db #0xff	; 255
   4403 FF                  323 	.db #0xff	; 255
   4404 FF                  324 	.db #0xff	; 255
   4405 FF                  325 	.db #0xff	; 255
   4406 FF                  326 	.db #0xff	; 255
   4407 FF                  327 	.db #0xff	; 255
   4408 FF                  328 	.db #0xff	; 255
   4409 FF                  329 	.db #0xff	; 255
   440A FF                  330 	.db #0xff	; 255
   440B FF                  331 	.db #0xff	; 255
   440C FF                  332 	.db #0xff	; 255
   440D FF                  333 	.db #0xff	; 255
   440E FF                  334 	.db #0xff	; 255
   440F FF                  335 	.db #0xff	; 255
   4410 FF                  336 	.db #0xff	; 255
   4411 FF                  337 	.db #0xff	; 255
   4412 FF                  338 	.db #0xff	; 255
   4413 FF                  339 	.db #0xff	; 255
   4414 FF                  340 	.db #0xff	; 255
   4415 FF                  341 	.db #0xff	; 255
   4416 FF                  342 	.db #0xff	; 255
   4417 FF                  343 	.db #0xff	; 255
   4418 FF                  344 	.db #0xff	; 255
   4419 FF                  345 	.db #0xff	; 255
   441A FF                  346 	.db #0xff	; 255
   441B FF                  347 	.db #0xff	; 255
   441C FF                  348 	.db #0xff	; 255
   441D FF                  349 	.db #0xff	; 255
   441E FF                  350 	.db #0xff	; 255
   441F FF                  351 	.db #0xff	; 255
   4420                     352 _tiles_09:
   4420 FF                  353 	.db #0xff	; 255
   4421 FF                  354 	.db #0xff	; 255
   4422 FF                  355 	.db #0xff	; 255
   4423 FF                  356 	.db #0xff	; 255
   4424 FF                  357 	.db #0xff	; 255
   4425 FF                  358 	.db #0xff	; 255
   4426 FF                  359 	.db #0xff	; 255
   4427 FF                  360 	.db #0xff	; 255
   4428 FF                  361 	.db #0xff	; 255
   4429 FF                  362 	.db #0xff	; 255
   442A FF                  363 	.db #0xff	; 255
   442B FF                  364 	.db #0xff	; 255
   442C FF                  365 	.db #0xff	; 255
   442D FF                  366 	.db #0xff	; 255
   442E FF                  367 	.db #0xff	; 255
   442F FF                  368 	.db #0xff	; 255
   4430 FF                  369 	.db #0xff	; 255
   4431 FF                  370 	.db #0xff	; 255
   4432 FF                  371 	.db #0xff	; 255
   4433 FF                  372 	.db #0xff	; 255
   4434 FF                  373 	.db #0xff	; 255
   4435 FF                  374 	.db #0xff	; 255
   4436 FF                  375 	.db #0xff	; 255
   4437 FF                  376 	.db #0xff	; 255
   4438 FF                  377 	.db #0xff	; 255
   4439 FF                  378 	.db #0xff	; 255
   443A FF                  379 	.db #0xff	; 255
   443B FF                  380 	.db #0xff	; 255
   443C FF                  381 	.db #0xff	; 255
   443D FF                  382 	.db #0xff	; 255
   443E FF                  383 	.db #0xff	; 255
   443F FF                  384 	.db #0xff	; 255
   4440                     385 _tiles_10:
   4440 FF                  386 	.db #0xff	; 255
   4441 FF                  387 	.db #0xff	; 255
   4442 FF                  388 	.db #0xff	; 255
   4443 FF                  389 	.db #0xff	; 255
   4444 FF                  390 	.db #0xff	; 255
   4445 FF                  391 	.db #0xff	; 255
   4446 FF                  392 	.db #0xff	; 255
   4447 FF                  393 	.db #0xff	; 255
   4448 FF                  394 	.db #0xff	; 255
   4449 FF                  395 	.db #0xff	; 255
   444A FF                  396 	.db #0xff	; 255
   444B FF                  397 	.db #0xff	; 255
   444C FF                  398 	.db #0xff	; 255
   444D FF                  399 	.db #0xff	; 255
   444E FF                  400 	.db #0xff	; 255
   444F FF                  401 	.db #0xff	; 255
   4450 FF                  402 	.db #0xff	; 255
   4451 FF                  403 	.db #0xff	; 255
   4452 FF                  404 	.db #0xff	; 255
   4453 FF                  405 	.db #0xff	; 255
   4454 FF                  406 	.db #0xff	; 255
   4455 FF                  407 	.db #0xff	; 255
   4456 FF                  408 	.db #0xff	; 255
   4457 FF                  409 	.db #0xff	; 255
   4458 FF                  410 	.db #0xff	; 255
   4459 FF                  411 	.db #0xff	; 255
   445A FF                  412 	.db #0xff	; 255
   445B FF                  413 	.db #0xff	; 255
   445C FF                  414 	.db #0xff	; 255
   445D FF                  415 	.db #0xff	; 255
   445E FF                  416 	.db #0xff	; 255
   445F FF                  417 	.db #0xff	; 255
   4460                     418 _tiles_11:
   4460 FF                  419 	.db #0xff	; 255
   4461 FF                  420 	.db #0xff	; 255
   4462 FF                  421 	.db #0xff	; 255
   4463 FF                  422 	.db #0xff	; 255
   4464 FF                  423 	.db #0xff	; 255
   4465 FF                  424 	.db #0xff	; 255
   4466 FF                  425 	.db #0xff	; 255
   4467 FF                  426 	.db #0xff	; 255
   4468 FF                  427 	.db #0xff	; 255
   4469 FF                  428 	.db #0xff	; 255
   446A FF                  429 	.db #0xff	; 255
   446B FF                  430 	.db #0xff	; 255
   446C FF                  431 	.db #0xff	; 255
   446D FF                  432 	.db #0xff	; 255
   446E FF                  433 	.db #0xff	; 255
   446F FF                  434 	.db #0xff	; 255
   4470 FF                  435 	.db #0xff	; 255
   4471 FF                  436 	.db #0xff	; 255
   4472 FF                  437 	.db #0xff	; 255
   4473 FF                  438 	.db #0xff	; 255
   4474 FF                  439 	.db #0xff	; 255
   4475 FF                  440 	.db #0xff	; 255
   4476 FF                  441 	.db #0xff	; 255
   4477 FF                  442 	.db #0xff	; 255
   4478 FF                  443 	.db #0xff	; 255
   4479 FF                  444 	.db #0xff	; 255
   447A FF                  445 	.db #0xff	; 255
   447B FF                  446 	.db #0xff	; 255
   447C FF                  447 	.db #0xff	; 255
   447D FF                  448 	.db #0xff	; 255
   447E FF                  449 	.db #0xff	; 255
   447F FF                  450 	.db #0xff	; 255
                            451 	.area _INITIALIZER
                            452 	.area _CABS (ABS)
