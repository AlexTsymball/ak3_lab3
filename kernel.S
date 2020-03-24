.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb
#define A #3
#define B #1

.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
    .word __stack_start 
    .word __kernel_reset__+1
    .size vtable_kernel, .-vtable_kernel

.section .rodata
    data: .asciz "kernel started!\n"
    final: .asciz "Value in register #2: "

.section .text
__kernel_reset__:
    ldr r0, =data
    bl dbgput_line
    
     // calculate 
//c
    mov r0, #1
//a
    mov r1, #1
//b
    mov r2, #2
//1
    mov r3, B
//3
    mov r4, A
   
    sub r1, r2
    mul r1, r4
    mov r4, #2
l:
    mul r3, r4
    sub r0, #1
    cmp r0, 0
    bne l
    add r2, r1, r3
        
    ldr r0, =final
    bl dbgput
    mov r0, r2
    bl dbgput_num
    
    end:
    b end

