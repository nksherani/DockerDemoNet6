
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
ARG ENVIRONMENT
# Copy only the sln ( when you have more files in the root folder make sure to copy them here. For ex -nuget.config )
WORKDIR /app
COPY ./*.sln ./


# Copy the main source project files
COPY src/*/*.csproj ./
RUN for file in $(ls *.csproj); do mkdir -p src/${file%.*}/ && echo $file &&  mv $file src/${file%.*}/; done

# Copy the test project files
#COPY tests/*/*.csproj ./
#RUN for file in $(ls *.csproj); do mkdir -p tests/${file%.*}/ && mv $file tests/${file%.*}/; done

RUN echo $(ls -1) 

# Copy everything else and build app
COPY . .
RUN dotnet build -c Release

# testrunner
#
#FROM build AS testrunner
#WORKDIR /app/tests/CNH.Products.NovatelActivation.UnitTests
#ENTRYPOINT dotnet test --results-directory /app/artifacts --logger:trx
#

# api-publish
FROM build AS api-publish
WORKDIR /app/src/DockerDemoNet6
RUN dotnet publish -c Release -o out

# api image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS api
WORKDIR /app
EXPOSE 8080
EXPOSE 443
EXPOSE 80
ENV ASPNETCORE_ENVIRONMENT $ENVIRONMENT
COPY --from=api-publish app/src/DockerDemoNet6/out ./
ENTRYPOINT [ "dotnet", "DockerDemoNet6.dll" ]
