import prisma from "./client.js";
import { ApolloServer } from "@apollo/server";
import { startStandaloneServer } from "@apollo/server/standalone";
import { gql } from "graphql-tag";
(async function () {
    // .gql
    const typeDefs = gql `
    type Post {
      id: String
      title: String
      authorId: String
      Author: Author
    }

    type Author {
      id: String
      posts: [Post]
      username: String
      profilePicture: String
    }

    type Query {
      getAllPosts: [Post]
      getAllAuthors: [Author]
    }

    type Mutation {
      createPost(title: String, authorId: String): Post
      createAuthor(username: String, profilePicture: String): Author
    }
  `;
    const resolvers = {
        Query: {
            getAllPosts: async () => {
                const val = await prisma.post.findMany({
                    select: {
                        ...["id", "title", "authorId"].reduce((obj, k) => ({ ...obj, [k]: true }), {}),
                        Author: {
                            select: {
                                username: true,
                                id: true,
                            },
                        },
                    },
                });
                return val;
            },
            getAllAuthors: async () => {
                const val = await prisma.author.findMany({
                    select: {
                        ...["id", "username", "profilePicture"].reduce((obj, k) => ({ ...obj, [k]: true }), {}),
                        posts: {
                            select: {
                                id: true,
                                title: true,
                            },
                        },
                    },
                });
                return val;
            },
        },
        Mutation: {
            createPost: async (_parent, args) => {
                const post = await prisma.post.create({
                    data: {
                        title: args.title,
                        Author: { connect: { id: args.authorId } },
                    },
                });
                return post;
            },
            createAuthor: async (_parent, args) => {
                const post = await prisma.author.create({
                    data: {
                        username: args.username,
                        profilePicture: args.profilePicture,
                    },
                });
                return post;
            },
        },
    };
    const server = new ApolloServer({
        typeDefs,
        resolvers,
    });
    const { url } = await startStandaloneServer(server, {
        listen: { port: 4000 },
    });
    console.log(`Server is ready at: ${url}`);
})();
