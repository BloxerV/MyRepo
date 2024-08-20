s="0P"
s_joined_reversed = "".join(x for x in s if x.isalpha())
s_joined_reversed_lower = s_joined_reversed.lower()
len_s_joined_reversed_lower = len(s_joined_reversed_lower)
for i in range(len_s_joined_reversed_lower):
    if not s_joined_reversed_lower[i] == s_joined_reversed_lower[len_s_joined_reversed_lower - 1 - i]:
        print('false')
print('true')


'''
Given a string s, return true if it is a palindrome, otherwise return false.

A palindrome is a string that reads the same forward and backward. It is also case-insensitive and ignores all non-alphanumeric characters.

Example 1:

Input: s = "Was it a car or a cat I saw?"

Output: true

Explanation: After considering only alphanumerical characters we have "wasitacaroracatisaw", which is a palindrome.

Example 2:

Input: s = "tab a cat"

Output: false
'''