export enum Relevancy {
  all = "all",
  major = "major",
}

export interface Article {
  id?: string;
  title: string;
  content: string;
  image: string;
  published_on: Date;
  category_list: string[];
  relevancy: Relevancy;
  source_url: string;
}
