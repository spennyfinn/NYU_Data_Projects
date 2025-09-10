# Part 1 goes here!

class DecodeError(Exception):
    pass

class ChunkError(Exception):
    pass


class BitList:
    #constructor
    def __init__(self, string):
        #iterate through the string's chars
        for char in string:
            #if the value is not 0 or 1, raise an exception
            if(char != "0" and char != '1'):
                raise ValueError('Format is invalid; does not consist of only 0 and 1')
        #make the string parameter a self variable
        self.binary_string = string
       
    #equals function ==
    def __eq__(self, other):
        #check that it is an instance of BitList
        if isinstance(other, BitList):
            #return if they're equal 
            return self.binary_string == other.binary_string
        #otherwise, return False
        else:
            return False
        
    @staticmethod
    def from_ints(*args):
        li = []
        #iterate through the int args and add to a list
        for i in args:
            li.append(str(i))

        #turn the list into a string
        bin_str = "".join(li)
        #make an instance of BitList with the new string
        b= BitList(bin_str)
        return b
    
    #String method
    def __str__(self):
        return self.binary_string
    
    
    #Shifting the binary values one place to the left
    def arithmetic_shift_left(self):
        #get a substring of all the values from the second value and add a 0 to the end
        substr = self.binary_string[1:]+'0'
        #make it the new binary_string variable
        self.binary_string = substr
    
    #Shifting to the right, opposite of shifting left
    def arithmetic_shift_right(self):
        substr = self.binary_string[0] + self.binary_string[:-1]
        self.binary_string = substr

    def bitwise_and(self, other):
        #checking if they are the same instance
        if isinstance(other, BitList):
            #ensuring they are the same length
            if len(self.binary_string) == len(other.binary_string):
                #new list to hold the new bits since strings are immutable
                new_bits=[]
                #since they are the same length, use a for loop to iterate over the values
                for i in range(len(self.binary_string)):
                    #if both values hold a "1", then the new bit will be a "1"
                    if(self.binary_string[i]=='1' and other.binary_string[i]=='1'):
                        #append to list
                        new_bits.append("1")
                    #otherwise, append a '0'
                    else:
                        new_bits.append('0')
        #convert the list to a str
        li_to_string = ''.join(new_bits)
        return BitList(li_to_string)
        

    def chunk(self, chunk_length):
        #raise an error if the chunk_length parameter doesn't evenly divide into the string length
        if len(self.binary_string) % chunk_length !=0:
            raise ChunkError(f"Each chunk will not have {chunk_length} values in it.")
        
        #break the string into individual integers chunked into groups of chunk_length size
        return [[int(char) for char in self.binary_string[i:i + chunk_length]] for i in range(0, len(self.binary_string), chunk_length)]

    def decode(self, encoding = 'utf-8'):
       #only take 'us-ascii' or 'utf-8'
       if encoding not in ('us-ascii', 'utf-8'):
           raise ValueError('The encoding is not supported')
       #variable for sequencing
       add=0
       #iterator variable
       i=0
       #variable to include the decoded message
       decoded=''
       #US-ASCII
       if encoding == 'us-ascii':
           #chunk into groups of 7 because ASCII is 7 bits
           chunked = self.chunk(7)
           #make a list of of string digits 
           chunk_str = ["".join(str(bit) for bit in bits) for bits in chunked]
           #make a list of characters
           chars = [chr(int(chunk , 2)) for chunk in chunk_str]
           #join them together
           return "".join(chars)
       #UTF-8
       elif encoding == "utf-8":
           #loop to iterate through all binary digits 
           while i<len(self.binary_string):
            #get the first byte
            first_byte = self.binary_string[i:i+8]
            #variable to keep the number of bytes saved
            num_bytes= 0
            #SAVING THE NUMBER OF BYTES BASED ON HEADER, RAISE ERROR IF INVALID
            if first_byte.startswith('0'):
                num_bytes=1
            elif first_byte.startswith('110'):
                num_bytes =2
            elif first_byte.startswith('1110'):
                num_bytes=3
            elif first_byte.startswith('11110'):
                num_bytes=4
            else:
                raise DecodeError("The leading bytes are invalid")
            #get a byte
            sequence = self.binary_string[i:i+8*num_bytes]
            #increase i
            i += 8*num_bytes

            #ENSURE THAT THE FOLLOWING BITS START WITH '10', RIASE ERROR IF INVALID
            if num_bytes >1:
                for bit in range(1,num_bytes):
                    following_bytes = sequence[bit*8:(bit+1)*8]
                    if not following_bytes.startswith('10'):
                        raise DecodeError("The continuation bytes are invalid")
            #concatonate the non-header bits, convert to a decimal number
            if num_bytes ==1:
                decimal = int(self.binary_string[1+add:8+add],2)
                add=8
            elif num_bytes ==2:
                decimal = int(self.binary_string[3+add:8+add],2 + self.binary_string[10+add:16+add],2)   
                #add variable deals with indexing the string of bits for multiple characacters   
                add = 16    
            elif num_bytes == 3:
                decimal = int(self.binary_string[4+add:8+add] + self.binary_string[10+add:16+add] + self.binary_string[18+add:24+add], 2)
                add =24
            elif num_bytes == 4:
                decimal = int(self.binary_string[5+add:8+add] + self.binary_string[10+add:16+add] + self.binary_string[18+add:24+add] + self.binary_string[26+add:32+add], 2)
                add = 32
            #Get the character 
            decoded += chr(decimal)
          
       return decoded
       
           
            