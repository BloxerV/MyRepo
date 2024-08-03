nums = [1,2,4,6]
output = [1] * len(nums)

for i in range(len(nums)):
    output[i + 1] = nums[i] * output[i] #prefix array
postfix =  1

for i in range(len(nums) -1, -1, -1):
    output[i] *= postfix
    postfix *= nums[i]
return output


'''
Given an integer array nums, return an array output where output[i] is the product of all the elements of nums except nums[i].

Each product is guaranteed to fit in a 32-bit integer.

Follow-up: Could you solve it in O(n)O(n) time without using the division operation?

Example 1:

Input: nums = [1,2,4,6]

Output: [48,24,12,8]

Example 2:

Input: nums = [-1,0,1,2,3]

Output: [0,-6,0,0,0]

Constraints:

    2 <= nums.length <= 1000
    -20 <= nums[i] <= 20
'''