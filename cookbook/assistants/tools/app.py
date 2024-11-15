import logging
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

# Configure logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

app = FastAPI()

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    logger.debug("Root endpoint called")
    return {"Hello": "World"}

@app.get("/health")
def health_check():
    logger.debug("Health check endpoint called")
    return {"status": "healthy"}

# Add startup event
@app.on_event("startup")
async def startup_event():
    logger.info("Application startup")
    logger.debug("Debug mode enabled")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=7777, log_level="debug")
