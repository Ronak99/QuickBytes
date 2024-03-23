export enum Relevancy {
  all = "all",
  major = "major",
}

export interface Article {
  id?: string;
  title: string;
  content: string;
  published_on: Date;
  category_list: [];
  relevancy: Relevancy;
  source_url: string;
  image: string;
}
