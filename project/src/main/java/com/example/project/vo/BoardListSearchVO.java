package com.example.project.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class BoardListSearchVO {

	//검색분류와 검색어
	private String type, keyword;
	
	@ToString.Include
	public boolean isSearch() {
		return type != null && keyword != null;
	}	
	
	//현재 페이지 번호(없을 경우 1로 설정, 1페이지에 10개씩 노출)
	private int p = 1;
	private int size = 10;
	
	@ToString.Include
	public int startRow() {
		return endRow() - (size - 1);
	}
	
	@ToString.Include
	public int endRow() {
		return p * size;
	}
	
	private int startRow = startRow();
	private int endRow = endRow();
	
	//총 게시글 수
	private int count;
	
	//화면에 표시할 블럭 개수
	private int blockSize = 5;
	
	//페이지 갯수
	@ToString.Include
	public int pageCount() {
		return (count + size - 1) / size;
	}
	
	//해당 페이지의 스타트블럭
	@ToString.Include
	public int startBlock() {
		return (p - 1) / blockSize * blockSize + 1;
	}
	
	//해당 페이지의 엔드블럭
	@ToString.Include
	public int endBlock() {
		int value = startBlock() + blockSize - 1;
		return Math.min(value, lastBlock());
	}

	//이전블럭
	@ToString.Include
	public int prevBlock() {
		return startBlock() - 1;
	}
	
	//다음블럭
	@ToString.Include
	public int nextBlock() {
		return endBlock() + 1;
	}
	
	//첫블럭
	@ToString.Include 
	public int firstBlock() {
		return 1;
	}
	
	//마지막블럭
	@ToString.Include
	public int lastBlock() {
		return pageCount();
	}
	
	//첫 페이지라면
	@ToString.Include
	public boolean isFirst() {
		return p == 1;
	}
	
	//마지막 페이지라면
	@ToString.Include
	public boolean isLast() {
		return endBlock() == lastBlock();
	}
	
	//이전 버튼 실행은 스타트블럭이 1보다 클 때
	@ToString.Include
	public boolean hasPrev() {
		return startBlock() > 1;
	}
	
	//다음 버튼 실행은 마지막 블럭이 다음블럭보다 작을 때
	@ToString.Include
	public boolean hasNext() {
		return endBlock() < lastBlock();
	}
	
	//검색이나 크기 등이 유지될 수 있도록 Query String을 생성
	//- p를 제외한 나머지 항목들에 대한 파라미터 생성
	@ToString.Include
	public String parameter() {
		if(isSearch()) {
			return "size="+size+"&type="+type+"&keyword="+keyword;
		}
		else {
			return "size="+size;
		}
		
	}
	
}
