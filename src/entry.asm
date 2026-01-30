.section .text.entry
.global _start

_start:
    # 1. Core 0 performs initialization; others park in a loop.
    # OpenSBI passes the hartid in register a0.
    # Check if a0 is 0 (Primary Core). If not, jump to the wait loop.
    bnez a0, loop

    # 2. Setup Stack Pointer
    # Load the address of the stack top into the sp register.
    la sp, boot_stack_top

    # 3. Transfer control to Rust
    # Jump to the main Rust kernel entry point.
    call rust_main

    # 4. Safety Net
    # If rust_main ever returns, spin endlessly.
loop:
    j loop

# Reserve 64KB stack space per hart (currently shared, to be fixed for SMP)
.section .bss.stack
.global boot_stack_lower_bound
boot_stack_lower_bound:
    .space 4096 * 16
.global boot_stack_top
boot_stack_top:
