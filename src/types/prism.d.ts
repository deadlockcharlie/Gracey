declare module 'prismjs/components/prism-core' {
  export function highlight(code: string, grammar: any, language: string): string;
  export const languages: any;
}

declare module 'prismjs/components/prism-json' {}

declare module 'prismjs/themes/prism-tomorrow.css' {}
