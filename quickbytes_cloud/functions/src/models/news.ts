export enum Relevancy {
    all,
    major,
}

export interface News {
    id?: string,
    title: string,
    content: string,
    published_on: Date,
    category_list: [],
    relevancy: Relevancy,
    source_url: string,
}