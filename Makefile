# Target Arch
TARGET := riscv64gc-unknown-none-elf

# Compilation Mode (Default)
MODE := release

# Kernel Name
KERNEL_ELF = target/$(TARGET)/$(MODE)/Nebula-Core
KERNEL_BIN = $(KERNEL_ELF).bin

# Final Loading Address (Sync with linker.ld)
KERNEL_ENTRY_PA := 0x80200000

# Binutils Toolset (need llvm-tools)
OBJCOPY := rust-objcopy --binary-architecture=riscv64

# Default Action: Compile -> Convert -> Run
run: build
	@echo "Converting ELF to Binary..."
	@$(OBJCOPY) --strip-all $(KERNEL_ELF) -O binary $(KERNEL_BIN)
	@echo "Booting QEMU..."
	@qemu-system-riscv64 \
		-machine virt \
		-nographic \
		-bios bios/fw_jump.bin \
		-device loader,file=$(KERNEL_BIN),addr=$(KERNEL_ENTRY_PA) \
		-smp 1
		
# riscv64-unknown-elf-gdb 
# file /target/riscv64gc-unknown-none-elf/debug/Nebula-Core
# target remote :1234
debug: MODE := debug
debug: build-debug
	@echo "Converting ELF to Binary..."
	@$(OBJCOPY) --strip-all $(KERNEL_ELF) -O binary $(KERNEL_BIN)
	@echo "Booting QEMU..."
	@qemu-system-riscv64 \
		-machine virt \
		-nographic \
		-bios bios/fw_jump.bin \
		-device loader,file=$(KERNEL_BIN),addr=$(KERNEL_ENTRY_PA) \
		-smp 1 -S -s

build:
	@cargo build --release
	
build-debug:
	@cargo build

clean:
	@cargo clean

.PHONY: run build clean debug build-debug
