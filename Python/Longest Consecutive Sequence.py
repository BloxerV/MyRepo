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