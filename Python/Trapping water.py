def trap(self, height: List[int]) -> int:
    left, right = 0, len(heights) - 1
    suma = 0


    while left < right:
        res = (right - left) * min(heights[right], heights[left])
        suma = max(suma, res)

        if heights[left] == 0:
            left += 1

        else:
            right -= 1

    return suma
Jeśli lewy jest większy od lewgo + 1 to res = left - (left +1): 
aktualizacj o każdy skok res += left - (left +1) dopóki nowy lewy nie będzie równy bądź większy od lewego od którego to się zaczeło
while left < right:
    if  heights[left] > heights[left + 1]:
        res += heights[left] - height[left + 1]
        left += 1
        while heights[left] < heights[left + 1]
            left += 1   
        


'''
You are given an array non-negative integers heights which represent an elevation map. Each value heights[i] represents the height of a bar, which has a width of 1.

Return the maximum area of water that can be trapped between the bars.

Example 1:

Input: height = [0,2,0,3,1,0,1,3,2,1]

Output: 9

Constraints:

    1 <= height.length <= 1000
    0 <= height[i] <= 1000
'''