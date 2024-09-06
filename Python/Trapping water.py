def trap(height: list[int]) -> int:
    left, right = 0, len(height) - 1
    res = 0
    r = 0

    while height[right - 1] >= height[right]:
        right -= 1

    while height[left + 1] >= height[left]:
        left += 1

    while left < right:
        r = left + 1
        if height[left] > height[r]:
            res += height[left] - height[r]
            left += 1
        if height[left] <= height[r]:
            left = r

    return res

print(trap([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]))

'''
    while left < right:
        res = (right - left) * min(height[right], height[left])
        suma = max(suma, res)

        if height[left] == 0:
            left += 1

        else:
            right -= 1

    return suma
Jeśli lewy jest większy od lewgo + 1 to res = left - (left +1): 
aktualizacj o każdy skok res += left - (left +1) dopóki nowy lewy nie będzie równy bądź większy od lewego od którego to się zaczeło
'''

'''
You are given an array non-negative integers height which represent an elevation map. Each value height[i] represents the height of a bar, which has a width of 1.

Return the maximum area of water that can be trapped between the bars.

Example 1:

Input: height = [0,2,0,3,1,0,1,3,2,1]

Output: 9

Constraints:

    1 <= height.length <= 1000
    0 <= height[i] <= 1000
'''