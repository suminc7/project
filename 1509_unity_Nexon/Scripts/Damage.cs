using UnityEngine;
using System.Collections;

public class Damage : MonoBehaviour {
	
	public GameObject[] numbers;
	public Sprite[] sprites;
	public GameObject container;
	
	private SpriteRenderer spriteRenderer;
	private Vector3 currentPos;
	private GameObject monsterObj;
	
	void Start () {
		//SetNumber (null, 1, 5, Random.Range (10000, 20000));
	}
	
	// Update is called once per frame
	void Update () {
		
		
		if (monsterObj) {
			transform.LookAt(monsterObj.transform.position);
		}
	}
	
	public void SetNumber(GameObject monster, int depth, int len, float rndNum){
		Debug.Log ("---------------SetNumber:" + len);
		
		monsterObj = monster;

		
		for (int j = len; j < numbers.Length; j++) {
			Destroy(numbers[j].gameObject);
		}
		
		float wid = 0f;
		for (int i = 0; i < len; i++) {
			
			
			int substrNum = int.Parse (rndNum.ToString ().Substring (i, 1));
			SpriteRenderer numberSpr = numbers[i].GetComponent<SpriteRenderer> ();
			numberSpr.sprite = sprites [substrNum];
			numberSpr.sortingOrder = depth + i;
			
			float ny = Random.Range (-0.015f, 0.015f);
			ny = ny > 0 ? ny + 0.015f : ny - 0.015f;
			numberSpr.transform.localPosition = new Vector3(wid , ny, 0);
			wid -= numberSpr.bounds.size.x * 0.6f;
			
			LeanTween.alpha (numbers[i], 0, 0.3f).setDelay (0.7f).setOnComplete (RemoveDamage);
		}
		
		
		
		
		
		container.transform.localPosition = new Vector3 (wid * -0.6f, 0, 0);
		
		LeanTween.moveLocal (gameObject, transform.position + new Vector3 (0, 1, 0), 1.0f);
		transform.LookAt(monsterObj.transform.position);
		
	}
	
	void RemoveDamage(){
		Destroy (gameObject);
	}
	
	
}
