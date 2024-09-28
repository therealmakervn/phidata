# from time import time
# from enum import Enum
# from typing import Optional, Any, Dict, List
#
# from pydantic import BaseModel, ConfigDict, Field
#
# from phi.model.message import Message, MessageContext
#
#
# class WorkflowEvent(str, Enum):
#     """Events that can be sent by Workflow.run()"""
#
#     started = "Started"
#     completed = "Completed"
#     agent_response = "AgentResponse"
#
#
# class WorkflowResponse(BaseModel):
#     """Response returned by Workflow.run()"""
#
#     workflow_id: str
#     content: Optional[Any] = None
#     content_type: str = "str"
#     messages: Optional[List[Message]] = None
#     metrics: Optional[Dict[str, Any]] = None
#     tools: Optional[List[Dict[str, Any]]] = None
#     context: Optional[List[MessageContext]] = None
#     model: Optional[str] = None
#     event: str = RunResponseEvent.agent_response.value
#     created_at: int = Field(default_factory=lambda: int(time()))
#
#     model_config = ConfigDict(arbitrary_types_allowed=True)
