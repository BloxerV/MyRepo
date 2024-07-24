nums=[3,2,3,1,2,4,5,5,6,7,7,8,2,3,1,1,1,10,11,5,6,2,4,7,8,5,6]
k=10
done = []
anagram_dict = {}

for nu in nums:

    count = 0

    for i in range(len(nums)):

        if nu == nums[i]:

            count += 1

    if nu not in anagram_dict:

        anagram_dict[nu]=[]
        anagram_dict[nu].append(count)


klu = (list(sorted(anagram_dict.values(), reverse=True)))
answer = []


for a in range(len(klu)):

    for i in range(len(anagram_dict)):

        if klu[a] == list(anagram_dict.values())[i] and list(anagram_dict.keys())[i] not in answer:

            answer += [list(anagram_dict.keys())[i]]


for i in range(k):

    done += [answer[i]]

print(klu)
print(done)

