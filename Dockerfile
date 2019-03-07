FROM microsoft/dotnet:2.2-aspnetcore-runtime-stretch-slim AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.2-sdk-stretch AS build
WORKDIR /src
COPY ["hyspdrt-web.csproj", ""]
RUN dotnet restore "hyspdrt-web.csproj"
COPY . .
WORKDIR "/src"
RUN dotnet build "hyspdrt-web.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "hyspdrt-web.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "hyspdrt-web.dll"]