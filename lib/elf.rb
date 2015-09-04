require 'bindata'
require 'awesome_print'

class ElfParser < BinData::Record
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
    int16le :e_type
    # Arch
    int16le :e_machine
    int32le :e_version
    # This is the memory address of the entry point from where the process starts executing. This field is either 32 or 64 bits long depending on the format defined earlier.
    choice :e_entry, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32le, 2 => :int64le}
    # Points to the start of the program header table. It usually follows the file header immediately making the offset 0x40 for 64-bit ELF executables.
    choice :e_phoff, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32le, 2 => :int64le}
    # Points to the start of the section header table.
    choice :e_shoff, :selection => lambda{e_ident.ei_class}, :choices => {1 => :int32le, 2 => :int64le}
    # Interpretation of this field depends on the target architecture.
    int32le :e_flags
    # Contains the size of this header, normally 64 bytes for 64-bit and 52 for 32-bit format.
    int16le :e_ehsize
    # Contains the size of a program header table entry.
    int16le :e_phentsize
    # Contains the number of entries in the program header table.
    int16le :e_phnum
    # Contains the size of a section header table entry.
    int16le :e_shentsize
    # Contains the number of entries in the section header table.
    int16le :e_shnum
    # Contains index of the section header table entry that contains the section names.
    int16le :e_shstrndx

    ###########################
    #   User defined fields   #
    ###########################
    int8le :bits, :value => lambda{parse_bits(e_ident.ei_class)}
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

    ###########################
    #   Conditional function  #
    ###########################
end

class Elf
    attr_accessor :elf

    def initialize(file)
        io = File.open(file)
        @elf = ElfParser.read(io)   
    end

end

e = Elf.new "./datastore_7e64104f876f0aa3f8330a409d9b9924.elf"
ap e.elf
