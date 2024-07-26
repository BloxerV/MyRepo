'''
Design an algorithm to encode a list of strings to a single string. The encoded string is then decoded back to the original list of strings.

Please implement encode and decode

Example 1:

Input: ["neet","code","love","you"]

Output:["neet","code","love","you"]

Example 2:

Input: ["we","say",":","yes"]

Output: ["we","say",":","yes"]

Constraints:

    0 <= strs.length < 100
    0 <= strs[i].length < 200
    strs[i] contains only UTF-8 characters.
'''

class Solution:

    def encode(self, strs: List[str]) -> str:
        return "".join(strs)
        
    def decode(self, s: str) -> List[str]:
        lista = []
        word = ''
        for i in s:
            word += i
            if len(word) == 4:
                lista += [word]
                word = ''
        if word:
            lista += [word]

        print(lista)
        return lista