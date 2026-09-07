import re


class HashtagAnalyzer:

    def extract_hashtags(self, caption: str) -> list:
        hashtags = []

        caption = caption.lower()

        for word in caption.split():

            if word.startswith("#"):

                # Remove # from beginning
                hashtag = word[1:]

                # Remove punctuation
                hashtag = re.sub(r'[^\w\s]', '', hashtag)

                if hashtag:
                    hashtags.append(hashtag)

        return hashtags

    def compute_hashtag_frequency(self, hashtags: list) -> dict:
        frequency = {}

        for hashtag in hashtags:
            frequency[hashtag] = frequency.get(hashtag, 0) + 1

        return frequency

    def get_most_used_hashtag(self, freq_dict: dict) -> tuple:

        if not freq_dict:
            return None

        most_used = max(freq_dict.items(), key=lambda x: x[1])

        return most_used

    def filter_hashtags_by_frequency(self, freq_dict: dict, n: int) -> dict:

        filtered = {}

        for hashtag, count in freq_dict.items():

            if count >= n:
                filtered[hashtag] = count

        return filtered

analyzer = HashtagAnalyzer()

caption = "Loving the weather! #Travel #Food, #travel #Nature! #food"

hashtags = analyzer.extract_hashtags(caption)
print("Extracted Hashtags:", hashtags)

freq = analyzer.compute_hashtag_frequency(hashtags)
print("Hashtag Frequency:", freq)

most_used = analyzer.get_most_used_hashtag(freq)
print("Most Used Hashtag:", most_used)

filtered = analyzer.filter_hashtags_by_frequency(freq, 2)
print("Filtered Hashtags:", filtered)
