# 使用 Node.js 20 Alpine 镜像
FROM node:20-alpine

# 设置工作目录
WORKDIR /app

# 复制 package 文件（包括 lock 文件）
COPY package*.json ./

# 安装所有依赖（包含 devDependencies，用于 TypeScript 编译）
RUN npm ci

# 复制源代码
COPY . .

# 编译 TypeScript
RUN npm run build

# 暴露端口
EXPOSE 8000

# 启动命令（通过 supergateway 将 stdio 转 SSE）
CMD ["npx", "supergateway", "--stdio", "node dist/index.js", "--port", "8000", "--healthPath", "/health"]
