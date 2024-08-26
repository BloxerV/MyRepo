def maxArea(heights: list[int]) -> int:
    left, right = 0, len(heights) - 1
    suma = 0

    for i, a in enumerate(heights):

        while left < right:

            if heights[left] <= heights[right]:
                suma_of_i = (heights[left] * heights[left]) * ((len(heights) - 1) - (i + 1))
                left += 1
            elif heights[left] >= heights[right]:
                suma_of_i = (heights[right] * heights[right]) * ((len(heights) - 1) - (i + 1))
                right -= 1

            if suma < suma_of_i:
                suma = suma_of_i
                devider = ((len(heights) - 1) - (i + 1))

            else:
                left += 1


    return suma//devider

s = [1,7,2,5,12,3,500,500,7,8,4,7,3,6]
print(maxArea(s))



'''
You are given an integer array heights where heights[i] represents the height of the ithith bar.

You may choose any two bars to form a container. Return the maximum amount of water a container can store.

Example 1:

Input: height = [1,7,2,5,4,7,3,6]

Output: 36

Example 2:

Input: height = [2,2,2]

Output: 4

Constraints:

    2 <= height.length <= 1000
    0 <= height[i] <= 1000

'''