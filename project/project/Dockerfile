FROM mcr.microsoft.com/dotnet/runtime:6.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["project.csproj", "project/"]
RUN dotnet restore "project/project.csproj"
COPY . .
WORKDIR "/src/project"
RUN dotnet build "project.csproj" -c Release -o /app/build --runtime linux-x64

FROM build AS publish
RUN dotnet publish "project.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "project.dll"]
