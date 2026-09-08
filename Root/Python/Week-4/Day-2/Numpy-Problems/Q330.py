import re

class CustomerSentimentAnalyzer:

    def preprocess_text(self, text: str) -> list:
        text = text.lower()
        text = re.sub(r'[^\w\s]', '', text)
        words = text.split()
        return words

    def compute_word_frequency(self, words: list) -> dict:
        frequency = {}

        for word in words:
            frequency[word] = frequency.get(word, 0) + 1

        return frequency

    def get_most_frequent_word(self, freq_dict: dict) -> tuple:
        if not freq_dict:
            return None

        word = max(freq_dict, key=lambda x: freq_dict[x])

        return (word, freq_dict[word])

    def filter_words_by_frequency(self, freq_dict: dict, n: int) -> dict:
        filtered = {}

        for word, count in freq_dict.items():
            if count >= n:
                filtered[word] = count

        return filtered



obj = CustomerSentimentAnalyzer()

text = "Excellent service, excellent support! Very helpful."

words = obj.preprocess_text(text)
print(words)

freq = obj.compute_word_frequency(words)
print(freq)

most_frequent = obj.get_most_frequent_word(freq)
print(most_frequent)

filtered = obj.filter_words_by_frequency(freq, 2)
print(filtered)
