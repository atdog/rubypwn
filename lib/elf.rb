require 'bindata'
require 'pp'

class ElfParser < BinData::Record
    endian :little
    # magic number
    string :magic, :read_length => 4
    struct :e_ident do
        # 32bits or 64bits
        int8 :ei_class
        int8 :ei_data
        int8 :ei_version
        int8 :ei_osabi
        int8 :ei_abiversion
        # unused
        string :ei_pad, :read_length => 7
    end
    int16 :e_type
    # Arch
    int16 :e_machine
    int32 :e_version
    # This is the memory address of the entry point from where the process starts executing. This field is either 32 or 64 bits long depending on the format defined earlier.
    choice :e_entry, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32, 2 => :int64}
    # Points to the start of the program header table. It usually follows the fi header immediately making the offset 0x40 for 64-bit ELF executables.
    choice :e_phoff, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32, 2 => :int64}
    # Points to the start of the section header table.
    choice :e_shoff, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32, 2 => :int64}
    # Interpretation of this field depends on the target architecture.
    int32 :e_flags
    # Contains the size of this header, normally 64 bytes for 64-bit and 52 for 32-bit format.
    int16 :e_ehsize
    # Contains the size of a program header tab entry.
    int16 :e_phentsize
    # Contains the number of entries in the program header table.
    int16 :e_phnum
    # Contains the size of a section header tab entry.
    int16 :e_shentsize
    # Contains the number of entries in the section header table.
    int16 :e_shnum
    # Section header string table index
    int16 :e_shstrndx
    skip :length => lambda{e_shoff - e_ehsize}
    # Program header table
    #array :ph, :initial_length => :e_phnum do
        #int32 :p_type
        ## Segment bit mask (RWX)
        #int32 :p_flags
        ## Segment file offset
        #choice :p_offset, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32le, 2 => :int64le}
        ## Segment virtual address
        #choice :p_vaddr, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32le, 2 => :int64le}
        ## Segment physical address
        #choice :p_paddr, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32le, 2 => :int64le}
        ## Segment size in file
        #choice :p_filesz, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32le, 2 => :int64le}
        ## Segment size in memory
        #choice :p_memsz, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32le, 2 => :int64le}
        ## Segment alignment
        #choice :p_align, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32le, 2 => :int64le}
        ##string :p_segment, :read_length => lambda{p_filesz - e_phentsize}
    #end
    # Contains index of the section header tab entry that contains the section names.
    array :sh, :initial_length => lambda{e_shnum} do
        # Section name (string tbl index)
        int32 :sh_name
        int32 :sh_type
        choice :sh_flags, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32, 2 => :int64}
        # Section virtual addr at execution
        choice :sh_addr, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32, 2 => :int64}
        # Section file offset
        choice :sh_offset, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32, 2 => :int64}
        # Section size in bytes
        choice :sh_size, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32, 2 => :int64}
        # Link to another section
        int32 :sh_link
        int32 :sh_info
        # Section alignment
        choice :sh_addralign, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32, 2 => :int64}
        # Entry size if section holds table
        choice :sh_entsize, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32, 2 => :int64}
        string :type_str, :value => lambda{parse_sh_type(sh_type)}
        string :flag_str, :value => lambda{parse_sh_flags(sh_flags)}
        string :name_str
    end

    ###########################
    #   User defined fields   #
    ###########################
    int8 :bits, :value => lambda{parse_bits(e_ident.ei_class)}
    string :arch, :value => lambda{parse_arch(e_machine)}
    string :type, :value => lambda{parse_type(e_type)}

    def parse_bits(ei_class)
        ei_class == 1 ? 32 : 64
    end

    def parse_arch(e_machine)
        machine = {
            0x02 => "SPARC",
            0x03 => "x86",
            0x08 => "MIPS",
            0x14 => "PowerPC",
            0x28 => "ARM",
            0x2a => "SuperH",
            0x32 => "IA64",
            0x3e => "x86-64",
            0xb7 => "AArch64",
        }
        machine[e_machine]
    end

    def parse_type(e_type)
        type ={
            1 => "relocatable",
            2 => "executable",
            3 => "shared",
            4 => "core",
        }
        type[e_type]
    end

    def parse_sh_type(sh_type)
        type = {
            0 => "NULL", #     /* Section header table entry unused */
            1 => "PROGBITS", #     /* Program data */
            2 => "SYMTAB", #     /* Symbol table */
            3 => "STRTAB", #     /* String table */
            4 => "RELA", #     /* Relocation entries with addends */
            5 => "HASH", #     /* Symbol hash table */
            6 => "DYNAMIC", #     /* Dynamic linking information */
            7 => "NOTE", #     /* Notes */
            8 => "NOBITS", #     /* Program space with no data (bss) */
            9 => "REL", #     /* Relocation entries, no addends */
            10 => "SHLIB", #        /* Reserved */
            11 => "DYNSYM", #        /* Dynamic linker symbol table */
            14 => "INIT_ARRAY", #        /* Array of constructors */
            15 => "FINI_ARRAY", #        /* Array of destructors */
            16 => "PREINIT_ARRAY", #        /* Array of pre-constructors */
            17 => "GROUP", #        /* Section group */
            18 => "SYMTAB_SHNDX", #        /* Extended section indeces */
            19 => "NUM", #        /* Number of defined types.  */
            0x60000000 => "LOOS", #    /* Start OS-specific.  */
            0x6ffffff5 => "GNU_ATTRIBUTES", #   /* Object attributes.  */
            0x6ffffff6 => "GNU_HASH", #    /* GNU-style hash table.  */
            0x6ffffff7 => "GNU_LIBLIST", #    /* Prelink library list */
            0x6ffffff8 => "CHECKSUM", #    /* Checksum for DSO content.  */
            0x6ffffffa => "SUNW_move", #
            0x6ffffffb => "SUNW_COMDAT", #
            0x6ffffffc => "SUNW_syminfo", #
            0x6ffffffd => "GNU_verdef", #    /* Version definition section.  */
            0x6ffffffe => "GNU_verneed", #    /* Version needs section.  */
            0x6fffffff => "GNU_versym", #    /* Version symbol table.  */
            0x70000000 => "LOPROC", #    /* Start of processor-specific */
            0x7fffffff => "HIPROC", #    /* End of processor-specific */
            0x80000000 => "LOUSER", #    /* Start of application-specific */
            0x8fffffff => "HIUSER", #    /* End of application-specific */
        }
        type[sh_type]
    end

    def parse_sh_flags(sh_flags)
        flags = {
            (1 << 0)   => "WRITE", # /* Writable */
            (1 << 1)   => "ALLOC", # /* Occupies memory during execution */
            (1 << 2)   => "EXECINSTR", # /* Executable */
            (1 << 4)   => "MERGE", # /* Might be merged */
            (1 << 5)   => "STRINGS", # /* Contains nul-terminated strings */
            (1 << 6)   => "INFO_LINK", # /* `sh_info' contains SHT index */
            (1 << 7)   => "LINK_ORDER", # /* Preserve order after combining */
            (1 << 8)   => "OS_NONCONFORMING", # /* Non-standard OS specific handling required */
            (1 << 9)   => "GROUP", # /* Section is member of a group.  */
            (1 << 10)  => "TLS", # /* Section hold thread-local data.  */
            0x0ff00000 => "MASKOS", # /* OS-specific.  */
            0xf0000000 => "MASKPROC", # /* Processor-specific */
            (1 << 30)  => "ORDERED", # /* Special ordering requirement (Solaris).  */
            (1 << 31)  => "EXCLUDE", # /* Section is excluded unless referenced or allocated (Solaris).*/
        }
        result = []
        flags.each do |k, v|
            if (sh_flags & k) > 0
                result.push v
            end
        end
        result.join "|"
    end
end


class Symtab32 < BinData::Record
    endian :little
    int32 :st_name        #/* Symbol name (string tbl index) */
    int32 :st_value       #/* Symbol value */
    int32 :st_size        #/* Symbol size */
    int8 :st_info         #/* Symbol type and binding */
    int8 :st_other        #/* Symbol visibility */
    int16 :st_shndx       #/* Section index */
    string :name_str
end

class Symtab64 < BinData::Record
    endian :little
    int32 :st_name        #/* Symbol name (string tbl index) */
    int8 :st_info         #/* Symbol type and binding */
    int8 :st_other        #/* Symbol visibility */
    int16 :st_shndx       #/* Section index */
    int64 :st_value       #/* Symbol value */
    int64 :st_size        #/* Symbol size */
    string :name_str
end

class Elf

    def initialize(file)
        # To avoid unicode
        binary = File.read(file).force_encoding('binary')
        # To fix bugs leading eof, that's why here is a newline ...
        elf = ElfParser.read(binary + "\n")
        # Section name assignment
        assign_section_name(binary, elf)
        # parse symbol table
        parse_symtab(binary, elf)
        #pp elf
    end

    private
    def assign_section_name(binary, elf)
        strtab_offset = elf.sh[elf.e_shstrndx].sh_offset.to_i
        strtab = binary[(strtab_offset)..-1]
        elf.e_shnum.times do |i|
            sh_name = elf.sh[i].sh_name.to_i
            elf.sh[i].name_str.assign BinData::Stringz.read strtab[sh_name..-1]
        end
    end

    def parse_symtab(binary, elf)
        # find dynamic symtab
        symtab = nil
        elf.e_shnum.times do |i|
            if elf.sh[i].name_str.to_s == ".dynsym"
                if elf.e_ident[:ei_class] == 1
                    symtab = BinData::Array.new(:type => :symtab32, :initial_length => elf.sh[i].sh_entsize)
                else
                    symtab = BinData::Array.new(:type => :symtab64, :initial_length => elf.sh[i].sh_entsize)
                end
                symtab = symtab.read binary[elf.sh[i].sh_offset, elf.sh[i].sh_size]
            end
        end

        # find dynamic strtab
        strtab = nil
        elf.e_shnum.times do |i|
            if elf.sh[i].name_str.to_s == ".dynstr"
                strtab = binary[elf.sh[i].sh_offset, elf.sh[i].sh_size]
            end
        end

        # find the name of dynamic symbol
        symtab.size.times do |i|
            symtab[i].name_str.assign BinData::Stringz.read strtab[symtab[i].st_name..-1]
        end

        pp symtab
        symtab
    end

end

e = Elf.new ARGV[0]
