//converts fraction to binary
//inumber is the number (float type) to be converted
//len is the length of the binary string
function i = idec2bin(inumber,len)
    i = ""
    for bi = 1:len
        inumber = inumber * 2
        f = floor(inumber)
        i = i + string(f)
        inumber = inumber - f
//        if inumber == 0 then
//            break
//        end
    end
endfunction