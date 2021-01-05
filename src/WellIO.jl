module WellIO

using FileIO
using Tables

"""
    load(file)
Load log well file from `filepath` and load it in defined structure.
"""
function load(filepath::String)
    file = FileIO.query(filepath)
    data = open(file) do f
            read(f, String)
        end
    #Splitting the data into table and rest of information
    datatable_block = match(r"~A(.*?)\Z"s, data)
    info_block = data[1:datatable_block.offset]
    #Extracting specific information from info_block
    version_block = match(r"~V(.*?)~"s, info_block)
    wellinfo_block = match(r"~W(.*?)~"s, info_block)
    curveinfo_block = match(r"~C(.*?)~"s, info_block)
    paraminfo_block = match(r"~P(.*?)~"s, info_block)
    otherinfo_block = match(r"~O(.*?)~"s, info_block)
    #Structure Data 
    if paraminfo_block === nothing && otherinfo_block === nothing
        information = WellData(version_block[1],wellinfo_block[1],curveinfo_block[1],paraminfo_block,otherinfo_block,datatable_block[1])
    elseif paraminfo_block === nothing
        information = WellData(version_block[1],wellinfo_block[1],curveinfo_block[1],paraminfo_block,otherinfo_block[1],datatable_block[1])
    elseif otherinfo_block === nothing
        information = WellData(version_block[1],wellinfo_block[1],curveinfo_block[1],paraminfo_block[1],otherinfo_block,datatable_block[1])
    else
        information = WellData(version_block[1],wellinfo_block[1],curveinfo_block[1],paraminfo_block[1],otherinfo_block[1],datatable_block[1])
    end
    #Returning defined Structure
    return(information)
end

struct WellData
    version::String 
    wellinfo::String
    curveinfo::String
    paraminfo::Union{String,Nothing}
    otherinfo::Union{String,Nothing}
    tabledata::String
end

end