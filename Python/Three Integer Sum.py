def three_sums(numbers: list[int]) -> list[list[int]]:

    i = 0
    left = 0
    right = len(numbers) - 1
    matching = []
    suma = numbers[left] + numbers[right] + numbers[i]
    while left < right:
        if suma == 0:
            matching += [numbers[left], numbers[right], numbers[i]]
        elif suma < 0:
            left += 1
        elif suma > 0:
            right -= 1
        for i in range(len(numbers)):
             suma = numbers[left] + numbers[right] + numbers[i]
    return matching

num = [-1,0,1,2,-1,-4]

print(three_sums(num))

'''
Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] where nums[i] + nums[j] + nums[k] == 0, and the indices i, j and k are all distinct.

The output should not contain any duplicate triplets. You may return the output and the triplets in any order.

Example 1:

Input: nums = [-1,0,1,2,-1,-4]

Output: [[-1,-1,2],[-1,0,1]]

Explanation:
nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
The distinct triplets are [-1,0,1] and [-1,-1,2].

Example 2:

Input: nums = [0,1,1]

Output: []

Explanation: The only possible triplet does not sum up to 0.

Example 3:

Input: nums = [0,0,0]

Output: [[0,0,0]]

Explanation: The only possible triplet sums up to 0.

Constraints:

    3 <= nums.length <= 1000
    -10^5 <= nums[i] <= 10^5

'''