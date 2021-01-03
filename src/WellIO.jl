module WellIO

using FileIO
using Tables

function load(filepath::String)
    file = FileIO.query(filepath)
    data = open(file) do f
            read(f, String)
        end
    #Splitting the data into table and rest of information
    datatable_block =match(r"~A(.*?)\Z"s, data)
    info_block = data[1:datatable_block.offset]
    #Extracting specific information from info_block
    version_block = match(r"~V(.*?)~"s, info_block)
    wellinfo_block = match(r"~W(.*?)~"s, info_block)
    curveinfo_block = match(r"~C(.*?)~"s, info_block)
    otherinfo_block = match(r"~O(.*?)~"s, info_block)
    #Structure Data 
    information = Segments(version_block,wellinfo_block,curve_info_block,otherinfo_block,datatable_block)
    return(information)
end

mutable struct Segments
    version::String
    wellinfo::String
    curveinfo::String
    optionalinfo::String
    tabledata::String
end


end