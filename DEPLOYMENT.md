# Deployment Guide for Smart AI Resume Analyzer

This guide provides instructions for deploying the Smart AI Resume Analyzer application in various environments, with a focus on resolving Chrome webdriver issues.

## Local Deployment

### Prerequisites
- Python 3.7 or higher
- Chrome browser installed
- pip for installing dependencies

### Steps for Windows
1. Clone the repository
2. Install dependencies:
   ```
   pip install -r requirements.txt
   ```
3. Run the application using the Python script:
   ```
   python run_app.py
   ```
   
   This script will automatically set up chromedriver and start the application.

   Alternatively, you can run the batch file:
   ```
   startup.bat
   ```

### Steps for Linux/Mac
1. Clone the repository
2. Install dependencies:
   ```
   pip install -r requirements.txt
   ```
3. Run the setup script to install the correct chromedriver:
   ```
   python setup_chromedriver.py
   ```
4. Run the application:
   ```
   streamlit run app.py
   ```

   Alternatively, you can use the startup script which handles both chromedriver setup and application startup:
   ```
   chmod +x startup.sh
   ./startup.sh
   ```

## Server Deployment (Linux)

### Installing Chrome on Ubuntu/Debian
```bash
# Update package list
sudo apt update

# Install Chrome dependencies
sudo apt install -y wget unzip fontconfig fonts-liberation libasound2 libatk-bridge2.0-0 libatk1.0-0 libatspi2.0-0 libcairo2 libcups2 libdrm2 libgbm1 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libxcomposite1 libxdamage1 libxfixes3 libxkbcommon0 libxrandr2 xdg-utils

# Download and install Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Verify installation
google-chrome --version
```

### Installing Chrome on CentOS/RHEL
```bash
# Add Chrome repository
sudo tee /etc/yum.repos.d/google-chrome.repo <<EOF
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF

# Install Chrome
sudo yum install -y google-chrome-stable

# Verify installation
google-chrome --version
```

### Running the Application on Server
After installing Chrome, deploy the application:

1. Clone the repository
2. Install dependencies:
   ```
   pip install -r requirements.txt
   ```
3. Make the startup script executable and run it:
   ```
   chmod +x startup.sh
   ./startup.sh
   ```

## Windows Server Deployment

### Prerequisites
- Python 3.7 or higher
- Chrome browser installed
- pip for installing dependencies

### Steps
1. Clone the repository
2. Install dependencies:
   ```
   pip install -r requirements.txt
   ```
3. Run the application using the Python script:
   ```
   python run_app.py
   ```
   
   This script will automatically set up chromedriver and start the application.

## Streamlit Cloud Deployment

When deploying to Streamlit Cloud, you need to ensure Chrome is available. Our application includes multiple fallback mechanisms to handle this.

### Steps for Streamlit Cloud
1. Push your code to a GitHub repository
2. Create a new app in Streamlit Cloud pointing to your repository
3. Make sure your `requirements.txt` includes all necessary dependencies:
   - `selenium>=4.10.0`
   - `webdriver-manager>=4.0.0`
   - `chromedriver-autoinstaller>=0.6.2`
4. Ensure the `packages.txt` file is in your repository with:
   ```
   chromium
   chromium-driver
   libglib2.0-0
   libnss3
   libgconf-2-4
   libfontconfig1
   xvfb
   wget
   unzip
   ```

### Troubleshooting Streamlit Cloud
If you encounter issues with Chrome on Streamlit Cloud:

1. Check the logs for specific error messages
2. Try adding a custom command to run the setup script before the app starts:
   - In the Streamlit Cloud settings, add a "Main file path" of `run_app.py` instead of `app.py`

## Docker Deployment

For Docker deployment, you need to include Chrome in your Docker image.

### Sample Dockerfile
```dockerfile
FROM python:3.9-slim

# Install Chrome
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    unzip \
    xvfb \
    libglib2.0-0 \
    libnss3 \
    libgconf-2-4 \
    libfontconfig1 \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Make scripts executable
RUN chmod +x startup.sh setup_chromedriver.py

# Expose port for Streamlit
EXPOSE 8501

# Run the startup script
CMD ["python", "run_app.py"]
```

## Troubleshooting Common Issues

### Error: "Service unexpectedly exited"
This usually indicates that Chrome cannot be started. Ensure:
- Chrome is installed
- You have the correct permissions
- You're using the `--no-sandbox` option in headless environments

### Error: "Chrome version must be between X and Y"
This indicates a version mismatch between Chrome and chromedriver:
- Run the `setup_chromedriver.py` script to install the matching chromedriver version
- The script automatically detects your Chrome version and downloads the compatible chromedriver

### Error: "Permission denied" when installing chromedriver
This is a permission issue:
- Try running the application with administrator privileges
- Ensure the user has write permissions to the installation directory
- Use the `setup_chromedriver.py` script which installs chromedriver in the user's home directory

### Error: "unknown error: DevToolsActivePort file doesn't exist"
This is common in containerized environments:
- Add `--disable-dev-shm-usage` to Chrome options (already included in our setup)
- Ensure you're using `--no-sandbox` in Docker/container environments

### Windows-specific issues
If you encounter issues on Windows:
- Make sure Chrome is installed in the standard location
- Try running the application as administrator
- Use the `run_app.py` script which handles setup automatically
- Check Windows Defender or antivirus software that might be blocking chromedriver

## Additional Resources
- [Selenium Documentation](https://www.selenium.dev/documentation/)
- [Chrome for Testing](https://developer.chrome.com/docs/chromium/chrome-for-testing)
- [Streamlit Deployment](https://docs.streamlit.io/streamlit-cloud/get-started/deploy-an-app) 