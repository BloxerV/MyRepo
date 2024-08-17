from collections import defaultdict

nums=[2,20,4,10,3,4,5]
sorted_nums = list(sorted(dict.fromkeys(nums)))
nums_consecutive = [1] * len(sorted_nums)
nums_consecutive_sets = defaultdict(set)
key = 0

for i in range(len(sorted_nums)):
    nums_consecutive_sets[key].add(sorted_nums[i])
    if i < len(sorted_nums) - 1 and sorted_nums[i] + 1 != sorted_nums[i + 1]:
        key +=1

print(max(len(item) for item in nums_consecutive_sets.values()))
