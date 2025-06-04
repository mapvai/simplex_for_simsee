# simplex_for_simsee
Diferentes implementaciones del metodo simplex y sus variantes para CPU y GPU orientado a ser usado por el simulador SIMSEE

La version v1_simplex_simsee_cpu_lib implementa el algorimo Simplex usado en SIMSEE en una biblioteca c para CPU.

La version v1_simplex_simsee_cpu_prog implementa el algorimo Simplex usado en SIMSEE en una programa c para CPU que contiene ejemplos usados por SIMSEE que se pueden correr directamente ejecutando el programa.

La version v2_simplex_simsee_gpu_lib implementa el algorimo Simplex usado en SIMSEE en una biblioteca c para GPU.

La version v2_simplex_simsee_gpu_prog implementa el algorimo Simplex usado en SIMSEE en una programa c para GPU que contiene ejemplos usados por SIMSEE que se pueden correr directamente ejecutando el programa.

La version v3_simplex_big_m_cpu_lib implementa el algorimo Simplex variante Big M en una biblioteca c para CPU.

La version v3_simplex_big_m_cpu_prog implementa el algorimo Simplex variante Big M en una programa c para CPU que contiene ejemplos usados por SIMSEE que se pueden correr directamente ejecutando el programa.

La version v4_simplex_big_m_gpu_prog implementa el algorimo Simplex variante Big M en una programa c para GPU que contiene ejemplos usados por SIMSEE que se pueden correr directamente ejecutando el programa.
Esta version implementa ini_mem y free_mem dentro del programa.

La version v5_simplex_big_m_2_cpu_prog implementa el algorimo Simplex BIG M Version 2, una version mejorada, en una programa c para CPU que contiene ejemplos usados por SIMSEE que se pueden correr directamente ejecutando el programa.

La version v6_simplex_big_m_2_gpu_prog implementa el algorimo Simplex BIG M Version 2, una version mejorada, en una programa c para GPU que contiene ejemplos usados por SIMSEE que se pueden correr directamente ejecutando el programa.

La version v7_simplex_two_phase_cpu_prog implementa el algorimo Simplex Two Phase, en una programa c para CPU que contiene ejemplos usados por SIMSEE que se pueden correr directamente ejecutando el programa.

La version v8_simplex_two_phase_gpu_prog implementa el algorimo Simplex Two Phase en una programa c para GPU que contiene ejemplos usados por SIMSEE que se pueden correr directamente ejecutando el programa.

La version v8_simplex_two_phase_gpu_prog implementa el algorimo Big M en una programa c para GPU que contiene ejemplos usados por SIMSEE que se pueden correr directamente ejecutando el programa. Esta version de Big M intenta mejorar la performance en GPU para la mejor version de las anteriores.

simsee_code_notes.pas Code used in SIMSEE. toStruct: convert SIMSEE simplex structure in GPUs tabloide structure. DumpSistemaToPlainTableForGPUs: Dump in a file the GPUs tabloide structure in a file