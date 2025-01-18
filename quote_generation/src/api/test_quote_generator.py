import unittest
from unittest.mock import patch, MagicMock
from flask import Flask
from api.quote_generator import app, generate_quote

# File: src/api/test_quote_generator.py


class TestQuoteGenerator(unittest.TestCase):

    @patch('src.api.quote_generator.generate_query_response')
    def test_generate_quote(self, mock_generate_query_response):
        # Arrange
        mock_generate_query_response.return_value = "Test quote"

        # Act
        quote = generate_quote()

        # Assert
        self.assertEqual(quote, "Test quote")
        mock_generate_query_response.assert_called_once_with("Generate an inspiring quote about new beginnings, personal growth, or fresh starts. The quote should be concise, no longer than 20 words.")

    @patch('src.api.quote_generator.generate_query_response')
    def test_generate_quote_api(self, mock_generate_query_response):
        # Arrange
        mock_generate_query_response.return_value = "Test quote"
        client = app.test_client()

        # Act
        response = client.get('/generate_quote')

        # Assert
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json, {"quote": "Test quote"})
        mock_generate_query_response.assert_called_once_with("Generate an inspiring quote about new beginnings, personal growth, or fresh starts. The quote should be concise, no longer than 20 words.")

if __name__ == "__main__":
    unittest.main()