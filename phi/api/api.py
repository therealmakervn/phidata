from typing import Dict

class Api:
    def __init__(self):
        self.headers: Dict[str, str] = {
            "Content-Type": "application/json",
        }
        self._authenticated_headers = self.headers

    @property 
    def authenticated_headers(self) -> Dict[str, str]:
        return self._authenticated_headers
