def isValid(s: str) -> bool:
    left, right = 0, len(s) - 1

    while left < right:
        if s[left] == '(':
            if s[right] == ')':
                left += 1
                right -= 1
            else:
                return False

        elif s[left] == '[':
            if s[right] == ']':
                left += 1
                right -= 1
            else:
                return False

        elif s[left] == '{':
            if s[right] == '}':
                left += 1
                right -= 1
            else:
                return False
        else:
            return False
    return True
st = "()[]{}"
print(isValid(st))

'''
You are given a string s consisting of the following characters: '(', ')', '{', '}', '[' and ']'.

The input string s is valid if and only if:

    Every open bracket is closed by the same type of close bracket.
    Open brackets are closed in the correct order.
    Every close bracket has a corresponding open bracket of the same type.

Return true if s is a valid string, and false otherwise.

Example 1:

Input: s = "[]"

Output: true

Example 2:

Input: s = "([{}])"

Output: true

Example 3:

Input: s = "[(])"

Output: false

Explanation: The brackets are not closed in the correct order.

Constraints:

    1 <= s.length <= 1000
'''