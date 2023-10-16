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
   4000                      55 _tiles_00:
   4000 5C                   56 	.db #0x5c	; 92
   4001 FC                   57 	.db #0xfc	; 252
   4002 5C                   58 	.db #0x5c	; 92
   4003 FC                   59 	.db #0xfc	; 252
   4004 0C                   60 	.db #0x0c	; 12
   4005 0C                   61 	.db #0x0c	; 12
   4006 0C                   62 	.db #0x0c	; 12
   4007 0C                   63 	.db #0x0c	; 12
   4008 0C                   64 	.db #0x0c	; 12
   4009 0C                   65 	.db #0x0c	; 12
   400A 0C                   66 	.db #0x0c	; 12
   400B 0C                   67 	.db #0x0c	; 12
   400C 5C                   68 	.db #0x5c	; 92
   400D FC                   69 	.db #0xfc	; 252
   400E 5C                   70 	.db #0x5c	; 92
   400F FC                   71 	.db #0xfc	; 252
   4010 FC                   72 	.db #0xfc	; 252
   4011 5C                   73 	.db #0x5c	; 92
   4012 FC                   74 	.db #0xfc	; 252
   4013 5C                   75 	.db #0x5c	; 92
   4014 0C                   76 	.db #0x0c	; 12
   4015 0C                   77 	.db #0x0c	; 12
   4016 0C                   78 	.db #0x0c	; 12
   4017 0C                   79 	.db #0x0c	; 12
   4018 0C                   80 	.db #0x0c	; 12
   4019 0C                   81 	.db #0x0c	; 12
   401A 0C                   82 	.db #0x0c	; 12
   401B 0C                   83 	.db #0x0c	; 12
   401C FC                   84 	.db #0xfc	; 252
   401D 5C                   85 	.db #0x5c	; 92
   401E FC                   86 	.db #0xfc	; 252
   401F 5C                   87 	.db #0x5c	; 92
   4020                      88 _tiles_01:
   4020 F2                   89 	.db #0xf2	; 242
   4021 F0                   90 	.db #0xf0	; 240
   4022 F0                   91 	.db #0xf0	; 240
   4023 F1                   92 	.db #0xf1	; 241
   4024 F0                   93 	.db #0xf0	; 240
   4025 F0                   94 	.db #0xf0	; 240
   4026 F0                   95 	.db #0xf0	; 240
   4027 F0                   96 	.db #0xf0	; 240
   4028 F0                   97 	.db #0xf0	; 240
   4029 F0                   98 	.db #0xf0	; 240
   402A B0                   99 	.db #0xb0	; 176
   402B F0                  100 	.db #0xf0	; 240
   402C F0                  101 	.db #0xf0	; 240
   402D F0                  102 	.db #0xf0	; 240
   402E B0                  103 	.db #0xb0	; 176
   402F F0                  104 	.db #0xf0	; 240
   4030 F3                  105 	.db #0xf3	; 243
   4031 E3                  106 	.db #0xe3	; 227
   4032 D3                  107 	.db #0xd3	; 211
   4033 F3                  108 	.db #0xf3	; 243
   4034 F3                  109 	.db #0xf3	; 243
   4035 C3                  110 	.db #0xc3	; 195
   4036 C3                  111 	.db #0xc3	; 195
   4037 F3                  112 	.db #0xf3	; 243
   4038 F2                  113 	.db #0xf2	; 242
   4039 F0                  114 	.db #0xf0	; 240
   403A F0                  115 	.db #0xf0	; 240
   403B F1                  116 	.db #0xf1	; 241
   403C F0                  117 	.db #0xf0	; 240
   403D F0                  118 	.db #0xf0	; 240
   403E 70                  119 	.db #0x70	; 112	'p'
   403F F0                  120 	.db #0xf0	; 240
   4040                     121 _tiles_02:
   4040 F3                  122 	.db #0xf3	; 243
   4041 F3                  123 	.db #0xf3	; 243
   4042 F3                  124 	.db #0xf3	; 243
   4043 F3                  125 	.db #0xf3	; 243
   4044 F3                  126 	.db #0xf3	; 243
   4045 F3                  127 	.db #0xf3	; 243
   4046 F3                  128 	.db #0xf3	; 243
   4047 A7                  129 	.db #0xa7	; 167
   4048 F3                  130 	.db #0xf3	; 243
   4049 F3                  131 	.db #0xf3	; 243
   404A F3                  132 	.db #0xf3	; 243
   404B F3                  133 	.db #0xf3	; 243
   404C F3                  134 	.db #0xf3	; 243
   404D F2                  135 	.db #0xf2	; 242
   404E F3                  136 	.db #0xf3	; 243
   404F F3                  137 	.db #0xf3	; 243
   4050 F2                  138 	.db #0xf2	; 242
   4051 F3                  139 	.db #0xf3	; 243
   4052 F3                  140 	.db #0xf3	; 243
   4053 F3                  141 	.db #0xf3	; 243
   4054 5B                  142 	.db #0x5b	; 91
   4055 F3                  143 	.db #0xf3	; 243
   4056 F3                  144 	.db #0xf3	; 243
   4057 F3                  145 	.db #0xf3	; 243
   4058 F3                  146 	.db #0xf3	; 243
   4059 A7                  147 	.db #0xa7	; 167
   405A F3                  148 	.db #0xf3	; 243
   405B F3                  149 	.db #0xf3	; 243
   405C F3                  150 	.db #0xf3	; 243
   405D F3                  151 	.db #0xf3	; 243
   405E F3                  152 	.db #0xf3	; 243
   405F F3                  153 	.db #0xf3	; 243
   4060                     154 _tiles_03:
   4060 FF                  155 	.db #0xff	; 255
   4061 FF                  156 	.db #0xff	; 255
   4062 FF                  157 	.db #0xff	; 255
   4063 FF                  158 	.db #0xff	; 255
   4064 FF                  159 	.db #0xff	; 255
   4065 FF                  160 	.db #0xff	; 255
   4066 FF                  161 	.db #0xff	; 255
   4067 FF                  162 	.db #0xff	; 255
   4068 FF                  163 	.db #0xff	; 255
   4069 FF                  164 	.db #0xff	; 255
   406A FF                  165 	.db #0xff	; 255
   406B FF                  166 	.db #0xff	; 255
   406C FF                  167 	.db #0xff	; 255
   406D FF                  168 	.db #0xff	; 255
   406E FF                  169 	.db #0xff	; 255
   406F FF                  170 	.db #0xff	; 255
   4070 FF                  171 	.db #0xff	; 255
   4071 FF                  172 	.db #0xff	; 255
   4072 FF                  173 	.db #0xff	; 255
   4073 FF                  174 	.db #0xff	; 255
   4074 FF                  175 	.db #0xff	; 255
   4075 FF                  176 	.db #0xff	; 255
   4076 FF                  177 	.db #0xff	; 255
   4077 FF                  178 	.db #0xff	; 255
   4078 FF                  179 	.db #0xff	; 255
   4079 FF                  180 	.db #0xff	; 255
   407A FF                  181 	.db #0xff	; 255
   407B FF                  182 	.db #0xff	; 255
   407C FF                  183 	.db #0xff	; 255
   407D FF                  184 	.db #0xff	; 255
   407E FF                  185 	.db #0xff	; 255
   407F FF                  186 	.db #0xff	; 255
   4080                     187 _tiles_04:
   4080 FF                  188 	.db #0xff	; 255
   4081 FF                  189 	.db #0xff	; 255
   4082 FF                  190 	.db #0xff	; 255
   4083 FF                  191 	.db #0xff	; 255
   4084 FF                  192 	.db #0xff	; 255
   4085 FF                  193 	.db #0xff	; 255
   4086 FF                  194 	.db #0xff	; 255
   4087 FF                  195 	.db #0xff	; 255
   4088 FF                  196 	.db #0xff	; 255
   4089 FF                  197 	.db #0xff	; 255
   408A FF                  198 	.db #0xff	; 255
   408B FF                  199 	.db #0xff	; 255
   408C FF                  200 	.db #0xff	; 255
   408D FF                  201 	.db #0xff	; 255
   408E FF                  202 	.db #0xff	; 255
   408F FF                  203 	.db #0xff	; 255
   4090 FF                  204 	.db #0xff	; 255
   4091 FF                  205 	.db #0xff	; 255
   4092 FF                  206 	.db #0xff	; 255
   4093 FF                  207 	.db #0xff	; 255
   4094 FF                  208 	.db #0xff	; 255
   4095 FF                  209 	.db #0xff	; 255
   4096 FF                  210 	.db #0xff	; 255
   4097 FF                  211 	.db #0xff	; 255
   4098 FF                  212 	.db #0xff	; 255
   4099 FF                  213 	.db #0xff	; 255
   409A FF                  214 	.db #0xff	; 255
   409B FF                  215 	.db #0xff	; 255
   409C FF                  216 	.db #0xff	; 255
   409D FF                  217 	.db #0xff	; 255
   409E FF                  218 	.db #0xff	; 255
   409F FF                  219 	.db #0xff	; 255
   40A0                     220 _tiles_05:
   40A0 FF                  221 	.db #0xff	; 255
   40A1 FF                  222 	.db #0xff	; 255
   40A2 FF                  223 	.db #0xff	; 255
   40A3 FF                  224 	.db #0xff	; 255
   40A4 FF                  225 	.db #0xff	; 255
   40A5 FF                  226 	.db #0xff	; 255
   40A6 FF                  227 	.db #0xff	; 255
   40A7 FF                  228 	.db #0xff	; 255
   40A8 FF                  229 	.db #0xff	; 255
   40A9 FF                  230 	.db #0xff	; 255
   40AA FF                  231 	.db #0xff	; 255
   40AB FF                  232 	.db #0xff	; 255
   40AC FF                  233 	.db #0xff	; 255
   40AD FF                  234 	.db #0xff	; 255
   40AE FF                  235 	.db #0xff	; 255
   40AF FF                  236 	.db #0xff	; 255
   40B0 FF                  237 	.db #0xff	; 255
   40B1 FF                  238 	.db #0xff	; 255
   40B2 FF                  239 	.db #0xff	; 255
   40B3 FF                  240 	.db #0xff	; 255
   40B4 FF                  241 	.db #0xff	; 255
   40B5 FF                  242 	.db #0xff	; 255
   40B6 FF                  243 	.db #0xff	; 255
   40B7 FF                  244 	.db #0xff	; 255
   40B8 FF                  245 	.db #0xff	; 255
   40B9 FF                  246 	.db #0xff	; 255
   40BA FF                  247 	.db #0xff	; 255
   40BB FF                  248 	.db #0xff	; 255
   40BC FF                  249 	.db #0xff	; 255
   40BD FF                  250 	.db #0xff	; 255
   40BE FF                  251 	.db #0xff	; 255
   40BF FF                  252 	.db #0xff	; 255
   40C0                     253 _tiles_06:
   40C0 FF                  254 	.db #0xff	; 255
   40C1 FF                  255 	.db #0xff	; 255
   40C2 FF                  256 	.db #0xff	; 255
   40C3 FF                  257 	.db #0xff	; 255
   40C4 FF                  258 	.db #0xff	; 255
   40C5 FF                  259 	.db #0xff	; 255
   40C6 FF                  260 	.db #0xff	; 255
   40C7 FF                  261 	.db #0xff	; 255
   40C8 FF                  262 	.db #0xff	; 255
   40C9 FF                  263 	.db #0xff	; 255
   40CA FF                  264 	.db #0xff	; 255
   40CB FF                  265 	.db #0xff	; 255
   40CC FF                  266 	.db #0xff	; 255
   40CD FF                  267 	.db #0xff	; 255
   40CE FF                  268 	.db #0xff	; 255
   40CF FF                  269 	.db #0xff	; 255
   40D0 FF                  270 	.db #0xff	; 255
   40D1 FF                  271 	.db #0xff	; 255
   40D2 FF                  272 	.db #0xff	; 255
   40D3 FF                  273 	.db #0xff	; 255
   40D4 FF                  274 	.db #0xff	; 255
   40D5 FF                  275 	.db #0xff	; 255
   40D6 FF                  276 	.db #0xff	; 255
   40D7 FF                  277 	.db #0xff	; 255
   40D8 FF                  278 	.db #0xff	; 255
   40D9 FF                  279 	.db #0xff	; 255
   40DA FF                  280 	.db #0xff	; 255
   40DB FF                  281 	.db #0xff	; 255
   40DC FF                  282 	.db #0xff	; 255
   40DD FF                  283 	.db #0xff	; 255
   40DE FF                  284 	.db #0xff	; 255
   40DF FF                  285 	.db #0xff	; 255
   40E0                     286 _tiles_07:
   40E0 FF                  287 	.db #0xff	; 255
   40E1 FF                  288 	.db #0xff	; 255
   40E2 FF                  289 	.db #0xff	; 255
   40E3 FF                  290 	.db #0xff	; 255
   40E4 FF                  291 	.db #0xff	; 255
   40E5 FF                  292 	.db #0xff	; 255
   40E6 FF                  293 	.db #0xff	; 255
   40E7 FF                  294 	.db #0xff	; 255
   40E8 FF                  295 	.db #0xff	; 255
   40E9 FF                  296 	.db #0xff	; 255
   40EA FF                  297 	.db #0xff	; 255
   40EB FF                  298 	.db #0xff	; 255
   40EC FF                  299 	.db #0xff	; 255
   40ED FF                  300 	.db #0xff	; 255
   40EE FF                  301 	.db #0xff	; 255
   40EF FF                  302 	.db #0xff	; 255
   40F0 FF                  303 	.db #0xff	; 255
   40F1 FF                  304 	.db #0xff	; 255
   40F2 FF                  305 	.db #0xff	; 255
   40F3 FF                  306 	.db #0xff	; 255
   40F4 FF                  307 	.db #0xff	; 255
   40F5 FF                  308 	.db #0xff	; 255
   40F6 FF                  309 	.db #0xff	; 255
   40F7 FF                  310 	.db #0xff	; 255
   40F8 FF                  311 	.db #0xff	; 255
   40F9 FF                  312 	.db #0xff	; 255
   40FA FF                  313 	.db #0xff	; 255
   40FB FF                  314 	.db #0xff	; 255
   40FC FF                  315 	.db #0xff	; 255
   40FD FF                  316 	.db #0xff	; 255
   40FE FF                  317 	.db #0xff	; 255
   40FF FF                  318 	.db #0xff	; 255
   4100                     319 _tiles_08:
   4100 FF                  320 	.db #0xff	; 255
   4101 FF                  321 	.db #0xff	; 255
   4102 FF                  322 	.db #0xff	; 255
   4103 FF                  323 	.db #0xff	; 255
   4104 FF                  324 	.db #0xff	; 255
   4105 FF                  325 	.db #0xff	; 255
   4106 FF                  326 	.db #0xff	; 255
   4107 FF                  327 	.db #0xff	; 255
   4108 FF                  328 	.db #0xff	; 255
   4109 FF                  329 	.db #0xff	; 255
   410A FF                  330 	.db #0xff	; 255
   410B FF                  331 	.db #0xff	; 255
   410C FF                  332 	.db #0xff	; 255
   410D FF                  333 	.db #0xff	; 255
   410E FF                  334 	.db #0xff	; 255
   410F FF                  335 	.db #0xff	; 255
   4110 FF                  336 	.db #0xff	; 255
   4111 FF                  337 	.db #0xff	; 255
   4112 FF                  338 	.db #0xff	; 255
   4113 FF                  339 	.db #0xff	; 255
   4114 FF                  340 	.db #0xff	; 255
   4115 FF                  341 	.db #0xff	; 255
   4116 FF                  342 	.db #0xff	; 255
   4117 FF                  343 	.db #0xff	; 255
   4118 FF                  344 	.db #0xff	; 255
   4119 FF                  345 	.db #0xff	; 255
   411A FF                  346 	.db #0xff	; 255
   411B FF                  347 	.db #0xff	; 255
   411C FF                  348 	.db #0xff	; 255
   411D FF                  349 	.db #0xff	; 255
   411E FF                  350 	.db #0xff	; 255
   411F FF                  351 	.db #0xff	; 255
   4120                     352 _tiles_09:
   4120 FF                  353 	.db #0xff	; 255
   4121 FF                  354 	.db #0xff	; 255
   4122 FF                  355 	.db #0xff	; 255
   4123 FF                  356 	.db #0xff	; 255
   4124 FF                  357 	.db #0xff	; 255
   4125 FF                  358 	.db #0xff	; 255
   4126 FF                  359 	.db #0xff	; 255
   4127 FF                  360 	.db #0xff	; 255
   4128 FF                  361 	.db #0xff	; 255
   4129 FF                  362 	.db #0xff	; 255
   412A FF                  363 	.db #0xff	; 255
   412B FF                  364 	.db #0xff	; 255
   412C FF                  365 	.db #0xff	; 255
   412D FF                  366 	.db #0xff	; 255
   412E FF                  367 	.db #0xff	; 255
   412F FF                  368 	.db #0xff	; 255
   4130 FF                  369 	.db #0xff	; 255
   4131 FF                  370 	.db #0xff	; 255
   4132 FF                  371 	.db #0xff	; 255
   4133 FF                  372 	.db #0xff	; 255
   4134 FF                  373 	.db #0xff	; 255
   4135 FF                  374 	.db #0xff	; 255
   4136 FF                  375 	.db #0xff	; 255
   4137 FF                  376 	.db #0xff	; 255
   4138 FF                  377 	.db #0xff	; 255
   4139 FF                  378 	.db #0xff	; 255
   413A FF                  379 	.db #0xff	; 255
   413B FF                  380 	.db #0xff	; 255
   413C FF                  381 	.db #0xff	; 255
   413D FF                  382 	.db #0xff	; 255
   413E FF                  383 	.db #0xff	; 255
   413F FF                  384 	.db #0xff	; 255
   4140                     385 _tiles_10:
   4140 FF                  386 	.db #0xff	; 255
   4141 FF                  387 	.db #0xff	; 255
   4142 FF                  388 	.db #0xff	; 255
   4143 FF                  389 	.db #0xff	; 255
   4144 FF                  390 	.db #0xff	; 255
   4145 FF                  391 	.db #0xff	; 255
   4146 FF                  392 	.db #0xff	; 255
   4147 FF                  393 	.db #0xff	; 255
   4148 FF                  394 	.db #0xff	; 255
   4149 FF                  395 	.db #0xff	; 255
   414A FF                  396 	.db #0xff	; 255
   414B FF                  397 	.db #0xff	; 255
   414C FF                  398 	.db #0xff	; 255
   414D FF                  399 	.db #0xff	; 255
   414E FF                  400 	.db #0xff	; 255
   414F FF                  401 	.db #0xff	; 255
   4150 FF                  402 	.db #0xff	; 255
   4151 FF                  403 	.db #0xff	; 255
   4152 FF                  404 	.db #0xff	; 255
   4153 FF                  405 	.db #0xff	; 255
   4154 FF                  406 	.db #0xff	; 255
   4155 FF                  407 	.db #0xff	; 255
   4156 FF                  408 	.db #0xff	; 255
   4157 FF                  409 	.db #0xff	; 255
   4158 FF                  410 	.db #0xff	; 255
   4159 FF                  411 	.db #0xff	; 255
   415A FF                  412 	.db #0xff	; 255
   415B FF                  413 	.db #0xff	; 255
   415C FF                  414 	.db #0xff	; 255
   415D FF                  415 	.db #0xff	; 255
   415E FF                  416 	.db #0xff	; 255
   415F FF                  417 	.db #0xff	; 255
   4160                     418 _tiles_11:
   4160 FF                  419 	.db #0xff	; 255
   4161 FF                  420 	.db #0xff	; 255
   4162 FF                  421 	.db #0xff	; 255
   4163 FF                  422 	.db #0xff	; 255
   4164 FF                  423 	.db #0xff	; 255
   4165 FF                  424 	.db #0xff	; 255
   4166 FF                  425 	.db #0xff	; 255
   4167 FF                  426 	.db #0xff	; 255
   4168 FF                  427 	.db #0xff	; 255
   4169 FF                  428 	.db #0xff	; 255
   416A FF                  429 	.db #0xff	; 255
   416B FF                  430 	.db #0xff	; 255
   416C FF                  431 	.db #0xff	; 255
   416D FF                  432 	.db #0xff	; 255
   416E FF                  433 	.db #0xff	; 255
   416F FF                  434 	.db #0xff	; 255
   4170 FF                  435 	.db #0xff	; 255
   4171 FF                  436 	.db #0xff	; 255
   4172 FF                  437 	.db #0xff	; 255
   4173 FF                  438 	.db #0xff	; 255
   4174 FF                  439 	.db #0xff	; 255
   4175 FF                  440 	.db #0xff	; 255
   4176 FF                  441 	.db #0xff	; 255
   4177 FF                  442 	.db #0xff	; 255
   4178 FF                  443 	.db #0xff	; 255
   4179 FF                  444 	.db #0xff	; 255
   417A FF                  445 	.db #0xff	; 255
   417B FF                  446 	.db #0xff	; 255
   417C FF                  447 	.db #0xff	; 255
   417D FF                  448 	.db #0xff	; 255
   417E FF                  449 	.db #0xff	; 255
   417F FF                  450 	.db #0xff	; 255
                            451 	.area _INITIALIZER
                            452 	.area _CABS (ABS)
