module WellIO

using FileIO
using Tables

function load(filepath::String)
    file = FileIO.query(filepath)
    data = open(file) do f
           read(f, String)
        end
    version_block = match(r"~V(.*?)~"s, data)
    wellinfo_block = match(r"~W(.*?)~"s, data)
    curveinfo_block = match(r"~C(.*?)~"s, data)
    otherinfo_block = match(r"~O(.*?)~"s, data)
    datatable_block = match(r"~A(.*?)\Z"s, data)
    return(version_block, wellinfo_block, curveinfo_block, otherinfo_block, datatable_block)
end


end