import unittest
from unittest.mock import patch, MagicMock
import os
import sys

# Add the src directory to the Python path
sys.path.append(os.path.join(os.path.dirname(__file__), '../../'))

from models.quote_model import generate_query_response

class TestGenerateQueryResponse(unittest.TestCase):

    @patch.dict(os.environ, {"GITHUB_TOKEN": "fake_token"})
    @patch("src.models.quote_model.ChatCompletionsClient")
    def test_generate_query_response_success(self, MockChatCompletionsClient):
        # Arrange
        mock_client_instance = MockChatCompletionsClient.return_value
        mock_response = MagicMock()
        mock_response.choices = [MagicMock(message=MagicMock(content="Test response"))]
        mock_client_instance.complete.return_value = mock_response

        # Act
        response = generate_query_response(query="Test query")

        # Assert
        self.assertEqual(response, "Test response")
        MockChatCompletionsClient.assert_called_once()
        mock_client_instance.complete.assert_called_once()

    @patch.dict(os.environ, {}, clear=True)
    def test_generate_query_response_no_github_token(self):
        # Act & Assert
        with self.assertRaises(EnvironmentError):
            generate_query_response(query="Test query")

if __name__ == "__main__":
    unittest.main()