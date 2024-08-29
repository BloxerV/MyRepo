def max_area(heights: list[int]) -> int:
    left, right = 0, len(heights) - 1
    suma = 0

    while left < right:
        res = (right - left) * min(heights[right], heights[left])
        suma = max(suma, res)

        if heights[left] < heights[right]:
            left += 1

        else:
            right -= 1

    return suma

s = [1,7,2,5,4,7,3,6]
print(max_area(s))



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