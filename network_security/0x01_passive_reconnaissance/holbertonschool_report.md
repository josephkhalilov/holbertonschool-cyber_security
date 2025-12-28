# Holbertonschool. com Passive Reconnaissance Report

## Executive Summary
This report contains passive reconnaissance findings for the holbertonschool. com domain using Shodan and other OSINT tools. 

## IP Ranges

| Subdomain | IP Address |
|-----------|------------|
| holbertonschool. com | 75.2.70.75 |
| holbertonschool. com | 99.83.190.102 |
| www.holbertonschool.com | 63.35.51.142 |
| apply.holbertonschool.com | 13.36.10.99 |
| support.holbertonschool.com | 104.16.53.111 |
| blog.holbertonschool.com | 192.0.78.131 |
| assets.holbertonschool.com | 52.85.96.95 |
| read.holbertonschool.com | 13.37.98.87 |
| help.holbertonschool.com | 75.2.70.75 |

## Technologies and Frameworks Detected

| Technology | Description |
|------------|-------------|
| AWS Global Accelerator | Main domain hosting |
| Amazon CloudFront | CDN for assets |
| Cloudflare | Support subdomain |
| WordPress | Blog platform |
| Webflow | Marketing pages |
| Zendesk | Customer support |
| Google Workspace | Email services |
| Ruby on Rails | Application framework |
| Nginx | Web server |
| Amazon S3 | Static file storage |

## DNS Information

- **Registrar:** Gandi SAS
- **Name Servers:** AWS Route 53
- **Mail Servers:** Google Workspace (aspmx.l. google.com)

## Security Observations

- SPF record configured for email authentication
- Multiple third-party integrations detected
- CDN protection on several subdomains

## Conclusion
The holbertonschool. com domain uses AWS infrastructure with various third-party services for different functionalities. 
