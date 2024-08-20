nums=[2,20,4,10,3,4,5]
nums_consecutive_sets = set(nums)
longest = 0

for i in nums_consecutive_sets:
    if i - 1 not in nums_consecutive_sets:
        lenght = 1
        while (i + lenght) in nums_consecutive_sets:
            lenght += 1
        longest = max(longest, lenght)
print(longest)

'''
Given an array of integers nums, return the length of the longest consecutive sequence of elements.

A consecutive sequence is a sequence of elements in which each element is exactly 1 greater than the previous element.

You must write an algorithm that runs in O(n) time.

Example 1:

Input: nums = [2,20,4,10,3,4,5]

Output: 4

Explanation: The longest consecutive sequence is [2, 3, 4, 5].

Example 2:

Input: nums = [0,3,2,5,4,6,1,1]

Output: 7
'''